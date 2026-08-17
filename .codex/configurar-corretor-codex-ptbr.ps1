$ErrorActionPreference = 'Stop'

function Get-OrderedUniqueString {
    param(
        [string[]]$Values
    )

    $seen = [System.Collections.Generic.HashSet[string]]::new(
        [System.StringComparer]::OrdinalIgnoreCase
    )

    foreach ($value in $Values) {
        if ([string]::IsNullOrWhiteSpace($value)) {
            continue
        }

        $normalizedValue = $value.Trim()
        if ($seen.Add($normalizedValue)) {
            Write-Output $normalizedValue
        }
    }
}

$codexProcesses = @(Get-Process -Name 'ChatGPT' -ErrorAction SilentlyContinue)

if ($codexProcesses.Count -gt 0) {
    throw 'Feche completamente o Codex antes de executar este script.'
}

$hasPortugueseSpellchecking = $false
foreach ($language in (Get-WinUserLanguageList)) {
    if ($language.LanguageTag -eq 'pt-BR' -and $language.Spellchecking) {
        $hasPortugueseSpellchecking = $true
        break
    }
}

if (-not $hasPortugueseSpellchecking) {
    throw 'O pacote pt-BR com correção ortográfica não está habilitado no Windows.'
}

$roamingDataPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::ApplicationData)
$localDataPath = [Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData)
if (
    [string]::IsNullOrWhiteSpace($roamingDataPath) -or
    [string]::IsNullOrWhiteSpace($localDataPath)
) {
    throw 'Não foi possível localizar as pastas AppData do usuário.'
}

$candidateRoots = [System.Collections.Generic.List[string]]::new()
$profileParentPaths = @(
    $roamingDataPath,
    $localDataPath,
    [System.IO.Path]::Combine($roamingDataPath, 'OpenAI'),
    [System.IO.Path]::Combine($localDataPath, 'OpenAI')
)

foreach ($profileParentPath in $profileParentPaths) {
    foreach ($profileName in @('Codex', 'ChatGPT')) {
        [void]$candidateRoots.Add(
            [System.IO.Path]::Combine($profileParentPath, $profileName)
        )
    }
}

$packagesPath = [System.IO.Path]::Combine($localDataPath, 'Packages')
if ([System.IO.Directory]::Exists($packagesPath)) {
    $codexPackages = Get-ChildItem -LiteralPath $packagesPath -Directory | Where-Object {
        $_.Name -like 'OpenAI.Codex_*' -or $_.Name -like 'OpenAI.ChatGPT_*'
    }

    foreach ($codexPackage in $codexPackages) {
        $containerParentPaths = @(
            [System.IO.Path]::Combine($codexPackage.FullName, 'LocalCache', 'Roaming'),
            [System.IO.Path]::Combine($codexPackage.FullName, 'LocalCache', 'Local'),
            [System.IO.Path]::Combine($codexPackage.FullName, 'LocalState'),
            [System.IO.Path]::Combine($codexPackage.FullName, 'RoamingState')
        )

        foreach ($containerParentPath in $containerParentPaths) {
            foreach ($profileName in @('Codex', 'ChatGPT')) {
                [void]$candidateRoots.Add(
                    [System.IO.Path]::Combine($containerParentPath, $profileName)
                )
            }
        }
    }
}

$relativePreferencePaths = [System.Collections.Generic.List[string]]::new()
[void]$relativePreferencePaths.Add('Preferences')
[void]$relativePreferencePaths.Add(
    [System.IO.Path]::Combine('Partitions', 'codex-browser-app', 'Preferences')
)

foreach ($webProfileName in @('Codex', 'ChatGPT')) {
    $webRoot = [System.IO.Path]::Combine('web', $webProfileName)
    [void]$relativePreferencePaths.Add(
        [System.IO.Path]::Combine($webRoot, 'Default', 'Preferences')
    )
    [void]$relativePreferencePaths.Add(
        [System.IO.Path]::Combine($webRoot, 'codex-browser-app', 'Preferences')
    )
    [void]$relativePreferencePaths.Add(
        [System.IO.Path]::Combine($webRoot, 'Partitions', 'codex-browser-app', 'Preferences')
    )
    [void]$relativePreferencePaths.Add(
        [System.IO.Path]::Combine(
            [System.IO.Path]::Combine($webRoot, 'Default', 'Partitions'),
            'codex-browser-app',
            'Preferences'
        )
    )
}

$candidatePaths = [System.Collections.Generic.List[string]]::new()
foreach ($candidateRoot in ($candidateRoots | Sort-Object -Unique)) {
    foreach ($relativePreferencePath in $relativePreferencePaths) {
        [void]$candidatePaths.Add(
            [System.IO.Path]::Combine($candidateRoot, $relativePreferencePath)
        )
    }
}

$preferencesMatches = @(
    $candidatePaths |
        Where-Object { [System.IO.File]::Exists($_) } |
        Sort-Object -Unique
)

if ($preferencesMatches.Count -eq 0) {
    throw 'Nenhum perfil do Codex foi encontrado nos locais suportados. Abra o aplicativo Codex, inicie uma conversa, feche-o pelo ícone da bandeja do Windows e execute novamente.'
}

$profileConfigurations = @(
    foreach ($preferencesPath in $preferencesMatches) {
        try {
            $preferences = [System.IO.File]::ReadAllText($preferencesPath) | ConvertFrom-Json
        }
        catch {
            throw "O perfil não contém JSON válido: $preferencesPath`n$($_.Exception.Message)"
        }

        [pscustomobject]@{
            Path = $preferencesPath
            Preferences = $preferences
        }
    }
)

$runId = '{0}-{1}' -f (
    [DateTime]::Now.ToString('yyyyMMdd-HHmmss')
), ([guid]::NewGuid().ToString('N').Substring(0, 8))
$utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
$backupPaths = [System.Collections.Generic.List[string]]::new()

foreach ($profileConfiguration in $profileConfigurations) {
    $preferencesPath = $profileConfiguration.Path
    $preferences = $profileConfiguration.Preferences

    if ($null -eq $preferences.intl) {
        $preferences | Add-Member -MemberType NoteProperty -Name intl -Value ([pscustomobject]@{})
    }

    $existingLanguages = [System.Collections.Generic.List[string]]::new()
    foreach ($languageProperty in @(
        $preferences.intl.selected_languages,
        $preferences.intl.accept_languages
    )) {
        if (-not [string]::IsNullOrWhiteSpace($languageProperty)) {
            foreach ($language in ($languageProperty -split ',')) {
                [void]$existingLanguages.Add($language)
            }
        }
    }

    $languageCandidates = @('pt-BR', 'pt')
    $languageCandidates += @($existingLanguages)
    $languageCandidates += @('en-US', 'en')
    $languages = @(
        Get-OrderedUniqueString -Values $languageCandidates
    )
    $serializedLanguages = $languages -join ','

    $preferences.intl | Add-Member `
        -MemberType NoteProperty `
        -Name selected_languages `
        -Value $serializedLanguages `
        -Force
    $preferences.intl | Add-Member `
        -MemberType NoteProperty `
        -Name accept_languages `
        -Value $serializedLanguages `
        -Force

    if ($null -eq $preferences.spellcheck) {
        $preferences | Add-Member -MemberType NoteProperty -Name spellcheck -Value ([pscustomobject]@{})
    }

    $dictionaryCandidates = @('pt-BR')
    if ($null -ne $preferences.spellcheck.dictionaries) {
        $dictionaryCandidates += @($preferences.spellcheck.dictionaries)
    }
    $dictionaryCandidates += @('en-US')
    $dictionaries = @(
        Get-OrderedUniqueString -Values $dictionaryCandidates
    )

    $preferences.spellcheck | Add-Member `
        -MemberType NoteProperty `
        -Name dictionaries `
        -Value $dictionaries `
        -Force
    $preferences.spellcheck | Add-Member `
        -MemberType NoteProperty `
        -Name dictionary `
        -Value '' `
        -Force

    $serialized = $preferences | ConvertTo-Json -Depth 100 -Compress
    $temporaryPath = "$preferencesPath.codex-portuguese-$([guid]::NewGuid().ToString('N')).tmp"
    $backupPath = "$preferencesPath.backup-$runId"

    try {
        [System.IO.File]::WriteAllText(
            $temporaryPath,
            $serialized + [Environment]::NewLine,
            $utf8WithoutBom
        )

        $verification = [System.IO.File]::ReadAllText($temporaryPath) | ConvertFrom-Json
        $verificationSelectedLanguages = @(
            $verification.intl.selected_languages -split ','
        )
        $verificationAcceptLanguages = @(
            $verification.intl.accept_languages -split ','
        )
        $verificationDictionaries = @($verification.spellcheck.dictionaries)

        if (
            $verificationSelectedLanguages[0] -ne 'pt-BR' -or
            $verificationAcceptLanguages[0] -ne 'pt-BR' -or
            $verificationDictionaries[0] -ne 'pt-BR' -or
            $verificationDictionaries -notcontains 'en-US'
        ) {
            throw "A configuração gerada não passou na validação: $preferencesPath"
        }

        [System.IO.File]::Copy($preferencesPath, $backupPath, $false)
        [void]$backupPaths.Add($backupPath)
        [System.IO.File]::Copy($temporaryPath, $preferencesPath, $true)
    }
    finally {
        if ([System.IO.File]::Exists($temporaryPath)) {
            [System.IO.File]::Delete($temporaryPath)
        }
    }

    Write-Host "Configurado: $preferencesPath"
}

Write-Host "Configuração concluída em $($profileConfigurations.Count) perfil(is)." -ForegroundColor Green
Write-Host 'Português (Brasil) foi definido como idioma e dicionário principal.'
Write-Host 'Backups:'
foreach ($backupPath in $backupPaths) {
    Write-Host "  $backupPath"
}
Write-Host 'Agora abra o Codex novamente.'
