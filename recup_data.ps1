# Heure d'exécution quotidienne (20:30)
$HeureExecution = "20:30"
# Chemin du répertoire source (disque) à partir duquel récupérer les fichiers et dossiers
$sourceDirectory = "C:\Users\rodel"

# Vérifie si le répertoire source existe
if (-not (Test-Path -Path $sourceDirectory -PathType Container)) {
    Write-Host "Le répertoire source n'existe pas ou n'est pas accessible."
    exit
}

# Chemin du répertoire de destination où les fichiers et dossiers seront copiés
$destinationDirectory = [System.Environment]::GetFolderPath('Desktop')

# Copie des fichiers et dossiers du répertoire source vers le répertoire de destination
try {
    Get-ChildItem -Path $sourceDirectory -Recurse | 
        ForEach-Object {
            $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $_.FullName.Replace($sourceDirectory, "")
            
            if ($_.PSIsContainer) {
                New-Item -Path $destinationPath -ItemType Directory -Force
            } else {
                Copy-Item -Path $_.FullName -Destination $destinationPath -Force
            }
        }

    Write-Host "Récupération des fichiers et dossiers terminée. Copiés sur le bureau."
} catch {
    Write-Host "Une erreur s'est produite : $($_.Exception.Message)"
}
Start-Sleep -Seconds 10

exit  # Ferme la fenêtre PowerShell