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

$manifest = Get-AppxPackageManifest -Package $pkg
$application = $manifest.Package.Applications.Application |
  Where-Object { $_.Id -eq 'App' } |
  Select-Object -First 1

if ($null -eq $application -or [string]::IsNullOrWhiteSpace($application.Executable)) {
  throw 'The main application executable was not found in the OpenAI.Codex package manifest.'
}

$appExe = Join-Path $pkg.InstallLocation ($application.Executable -replace '/', '\')
if (-not (Test-Path -LiteralPath $appExe)) {
  throw "ChatGPT executable was not found: $appExe"
}

if ([System.IO.Path]::GetFileName($appExe) -ne 'ChatGPT.exe') {
  throw "The OpenAI.Codex package manifest points to an unexpected executable: $appExe"
}

if (-not (Get-Command Invoke-CommandInDesktopPackage -ErrorAction SilentlyContinue)) {
  throw 'Invoke-CommandInDesktopPackage is not available on this Windows installation.'
}

Get-Process -Name ChatGPT, Codex, codex, node_repl, codex-code-mode-host -ErrorAction SilentlyContinue |
  Stop-Process -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 2

Invoke-CommandInDesktopPackage `
  -PackageFamilyName $pkg.PackageFamilyName `
  -AppId $application.Id `
  -Command $appExe `
  -Args '--do-not-de-elevate' `
  -PreventBreakaway
