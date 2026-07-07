$ErrorActionPreference = 'Stop'

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [Security.Principal.WindowsPrincipal]::new($identity)
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
  $pwsh = (Get-Command pwsh.exe -ErrorAction SilentlyContinue).Source
  if (-not $pwsh) {
    $pwsh = (Get-Command powershell.exe).Source
  }

  Start-Process -FilePath $pwsh -Verb RunAs -ArgumentList @(
    '-NoProfile',
    '-ExecutionPolicy',
    'Bypass',
    '-File',
    "`"$PSCommandPath`""
  )
  exit
}

$pkg = Get-AppxPackage OpenAI.Codex
if ($null -eq $pkg) {
  throw 'OpenAI.Codex package was not found.'
}

$codexExe = Join-Path $pkg.InstallLocation 'app\Codex.exe'
if (-not (Test-Path -LiteralPath $codexExe)) {
  throw "Codex executable was not found: $codexExe"
}

Get-Process -Name Codex, codex, node_repl -ErrorAction SilentlyContinue |
  Stop-Process -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 2

Start-Process -FilePath $codexExe -ArgumentList '--do-not-de-elevate' -WorkingDirectory (Split-Path $codexExe)
