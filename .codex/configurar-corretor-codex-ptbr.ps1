$ErrorActionPreference = 'Stop'

$codexProcesses = @(Get-CimInstance Win32_Process | Where-Object {
    $_.Name -eq 'ChatGPT.exe' -and $_.ExecutablePath -like '*OpenAI.Codex*'
})

if ($codexProcesses.Count -gt 0) {
    throw 'Feche completamente o Codex antes de executar este script.'
}

$portugueseLanguage = Get-WinUserLanguageList | Where-Object {
    $_.LanguageTag -eq 'pt-BR' -and $_.Spellchecking
}

if ($null -eq $portugueseLanguage) {
    throw 'O pacote pt-BR com correção ortográfica não está habilitado no Windows.'
}

$roamingDataPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::ApplicationData)
if ([string]::IsNullOrWhiteSpace($roamingDataPath)) {
    throw 'Não foi possível localizar a pasta AppData\Roaming do usuário.'
}

$preferencesPath = [System.IO.Path]::GetFullPath(
    [System.IO.Path]::Combine($roamingDataPath, 'Codex', 'web', 'Codex', 'Default', 'Preferences')
)
$expectedRoot = [System.IO.Path]::GetFullPath(
    [System.IO.Path]::Combine($roamingDataPath, 'Codex', 'web', 'Codex', 'Default')
) + [System.IO.Path]::DirectorySeparatorChar

if (-not $preferencesPath.StartsWith($expectedRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Caminho de preferências inesperado: $preferencesPath"
}

if (-not [System.IO.File]::Exists($preferencesPath)) {
    throw 'O perfil do Codex não foi encontrado. Abra o Codex uma vez, feche-o e execute novamente.'
}

$timestamp = [DateTime]::Now.ToString('yyyyMMdd-HHmmss')
$backupPath = "$preferencesPath.backup-$timestamp"
[System.IO.File]::Copy($preferencesPath, $backupPath, $false)

$preferences = [System.IO.File]::ReadAllText($preferencesPath) | ConvertFrom-Json

if ($null -eq $preferences.intl) {
    $preferences | Add-Member -MemberType NoteProperty -Name intl -Value ([pscustomobject]@{})
}
$preferences.intl | Add-Member `
    -MemberType NoteProperty `
    -Name selected_languages `
    -Value 'pt-BR,pt,en-US,en' `
    -Force

if ($null -eq $preferences.spellcheck) {
    $preferences | Add-Member -MemberType NoteProperty -Name spellcheck -Value ([pscustomobject]@{})
}
$preferences.spellcheck | Add-Member `
    -MemberType NoteProperty `
    -Name dictionaries `
    -Value @('pt-BR', 'en-US') `
    -Force
$preferences.spellcheck | Add-Member `
    -MemberType NoteProperty `
    -Name dictionary `
    -Value '' `
    -Force

$serialized = $preferences | ConvertTo-Json -Depth 100
$temporaryPath = "$preferencesPath.codex-portuguese-$([guid]::NewGuid().ToString('N')).tmp"
$utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)

try {
    [System.IO.File]::WriteAllText(
        $temporaryPath,
        $serialized + [Environment]::NewLine,
        $utf8WithoutBom
    )

    $verification = [System.IO.File]::ReadAllText($temporaryPath) | ConvertFrom-Json
    if (
        $verification.intl.selected_languages -ne 'pt-BR,pt,en-US,en' -or
        ($verification.spellcheck.dictionaries -join ',') -ne 'pt-BR,en-US'
    ) {
        throw 'A configuração gerada não passou na validação.'
    }

    [System.IO.File]::Copy($temporaryPath, $preferencesPath, $true)
}
finally {
    if ([System.IO.File]::Exists($temporaryPath)) {
        [System.IO.File]::Delete($temporaryPath)
    }
}

Write-Host 'Configuração concluída.' -ForegroundColor Green
Write-Host 'Idiomas: pt-BR, pt, en-US, en'
Write-Host 'Dicionários: pt-BR, en-US'
Write-Host "Backup: $backupPath"
Write-Host 'Agora abra o Codex novamente.'
