[CmdletBinding(DefaultParameterSetName = 'Start')]
param(
    [Parameter(Mandatory = $true, ParameterSetName = 'Start')]
    [string]$displayName,

    [Parameter(Mandatory = $true, ParameterSetName = 'Start')]
    [string]$launcherRoot,

    [Parameter(ParameterSetName = 'Start')]
    [switch]$checkOnly,

    [Parameter(Mandatory = $true, ParameterSetName = 'Worker')]
    [string]$requestPath
)

$ErrorActionPreference = 'Stop'

if ($PSCmdlet.ParameterSetName -eq 'Worker') {
    $exchangeRoot = Split-Path -Parent $requestPath
    $resultPath = Join-Path $exchangeRoot 'result.json'
    $result = [ordered]@{
        Success = $false
        Error = $null
        NoPackageIdentity = $false
        SameUser = $false
        ProgramsPath = $null
        LocalShortcut = $null
        StartMenuShortcut = $null
        Verified = $false
        CreatedPaths = @()
    }

    try {
        $request = Get-Content -LiteralPath $requestPath -Raw -Encoding UTF8 | ConvertFrom-Json
        Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
using System.Text;

public static class CodexShortcutNative
{
    [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
    public static extern int GetCurrentPackageFullName(ref uint packageFullNameLength, StringBuilder packageFullName);
}
'@
        [uint32]$length = 0
        $packageStatus = [CodexShortcutNative]::GetCurrentPackageFullName([ref]$length, $null)
        if ($packageStatus -ne 15700) {
            throw ('The shortcut helper still has package identity or the identity check failed. Windows error: ' + $packageStatus)
        }
        $result.NoPackageIdentity = $true

        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        try {
            if ($identity.User.Value -ne $request.UserSid) {
                throw 'The shortcut helper is running as a different Windows user.'
            }
            $result.SameUser = $true
        }
        finally {
            $identity.Dispose()
        }

        $programsPath = [Environment]::GetFolderPath('Programs')
        if ([string]::IsNullOrWhiteSpace($programsPath) -or -not [IO.Directory]::Exists($programsPath)) {
            throw 'The current user Start menu Programs folder is unavailable.'
        }
        $launcherRoot = [IO.Path]::GetFullPath($request.LauncherRoot)
        $shortcutName = 'Codex ' + $request.DisplayName + '.lnk'
        $localShortcut = Join-Path $launcherRoot $shortcutName
        $startMenuShortcut = Join-Path $programsPath $shortcutName
        $result.ProgramsPath = $programsPath
        $result.LocalShortcut = $localShortcut
        $result.StartMenuShortcut = $startMenuShortcut

        foreach ($destination in @($localShortcut, $startMenuShortcut)) {
            if (Test-Path -LiteralPath $destination) {
                throw ('A shortcut destination already exists: ' + $destination)
            }
        }

        if (-not $request.CheckOnly) {
            $scriptPath = Join-Path $launcherRoot 'codex-elevated-restart.ps1'
            $iconPath = Join-Path $launcherRoot 'codex.ico'
            if (-not [IO.File]::Exists($scriptPath) -or -not [IO.File]::Exists($iconPath)) {
                throw 'Install the PowerShell launcher and icon before creating shortcuts.'
            }

            $expected = [ordered]@{
                TargetPath = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
                Arguments = '-NoProfile -NonInteractive -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $scriptPath + '"'
                WorkingDirectory = $launcherRoot
                IconLocation = $iconPath + ',0'
                WindowStyle = 7
                Description = 'Open Codex ' + $request.DisplayName
            }
            $shell = New-Object -ComObject WScript.Shell
            $stagedShortcut = Join-Path $exchangeRoot $shortcutName
            $shortcut = $shell.CreateShortcut($stagedShortcut)
            foreach ($property in $expected.Keys) {
                $shortcut.$property = $expected[$property]
            }
            $shortcut.Save()

            foreach ($destination in @($localShortcut, $startMenuShortcut)) {
                # Copy without overwrite so a collision after the initial check also fails safely.
                [IO.File]::Copy($stagedShortcut, $destination, $false)
                $result.CreatedPaths += $destination
                $readback = $shell.CreateShortcut($destination)
                foreach ($property in $expected.Keys) {
                    if ($readback.$property -ne $expected[$property]) {
                        throw ('Shortcut verification failed for ' + $property + ': ' + $destination)
                    }
                }
            }
            $result.Verified = $true
        }
        $result.Success = $true
    }
    catch {
        $result.Error = $_.Exception.Message
    }

    $temporaryResult = $resultPath + '.tmp'
    $result | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $temporaryResult -Encoding UTF8
    [IO.File]::Move($temporaryResult, $resultPath)
    return
}

if ($displayName.Length -gt 48 -or $displayName -notmatch '^[\p{L}\p{Nd}](?:[\p{L}\p{Nd} _-]*[\p{L}\p{Nd}])?$') {
    throw 'Supply the validated instance display name (1-48 letters, digits, spaces, hyphens, or underscores).'
}
if (-not [IO.Path]::IsPathRooted($launcherRoot)) {
    throw 'LauncherRoot must be an absolute path.'
}

$userProfile = [Environment]::GetFolderPath('UserProfile')
$exchangeRoot = Join-Path $userProfile ('.codex-shortcuts-' + [guid]::NewGuid().ToString('N'))
[void][IO.Directory]::CreateDirectory($exchangeRoot)
$workerFinished = $false
$workerStarted = $false
try {
    # AppData (including TEMP) can be virtualized; exchange files must be visible outside the package.
    $workerPath = Join-Path $exchangeRoot 'install-shortcuts.ps1'
    [IO.File]::WriteAllText($workerPath, [IO.File]::ReadAllText($PSCommandPath), [Text.UTF8Encoding]::new($true))
    $requestPath = Join-Path $exchangeRoot 'request.json'
    $resultPath = Join-Path $exchangeRoot 'result.json'
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    try {
        @{
            DisplayName = $displayName
            LauncherRoot = [IO.Path]::GetFullPath($launcherRoot)
            CheckOnly = [bool]$checkOnly
            UserSid = $identity.User.Value
        } | ConvertTo-Json | Set-Content -LiteralPath $requestPath -Encoding UTF8
    }
    finally {
        $identity.Dispose()
    }

    $windowsPowerShell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
    $command = '"' + $windowsPowerShell + '" -NoProfile -NonInteractive -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $workerPath + '" -RequestPath "' + $requestPath + '"'
    $startup = New-CimInstance -ClassName Win32_ProcessStartup -ClientOnly -Property @{ ShowWindow = [uint16]0 }
    $created = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{
        CommandLine = $command
        CurrentDirectory = $userProfile
        ProcessStartupInformation = $startup
    }
    if ($created.ReturnValue -ne 0) {
        throw ('Could not start the shortcut helper. Windows error: ' + $created.ReturnValue)
    }
    $workerStarted = $true
    $deadline = [DateTime]::UtcNow.AddSeconds(30)
    while (-not [IO.File]::Exists($resultPath) -and [DateTime]::UtcNow -lt $deadline) {
        Start-Sleep -Milliseconds 100
    }
    if (-not [IO.File]::Exists($resultPath)) {
        throw ('Shortcut helper completion is unknown. Do not retry or remove its files until process ' + $created.ProcessId + ' finishes. Inspect: ' + $exchangeRoot)
    }

    $result = Get-Content -LiteralPath $resultPath -Raw -Encoding UTF8 | ConvertFrom-Json
    $workerFinished = $true
    if (-not $result.Success) {
        throw ('Shortcut helper failed: ' + ($result | ConvertTo-Json -Compress -Depth 4))
    }
    $result
}
finally {
    if ($workerFinished -or -not $workerStarted) {
        $resolvedExchange = [IO.Path]::GetFullPath($exchangeRoot)
        $expectedParent = [IO.Path]::GetFullPath($userProfile).TrimEnd('\') + '\'
        if (-not $resolvedExchange.StartsWith($expectedParent, [StringComparison]::OrdinalIgnoreCase)) {
            throw 'Refusing to clean up a helper directory outside the current user profile.'
        }
        Remove-Item -LiteralPath $resolvedExchange -Recurse
    }
}
