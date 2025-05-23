$tempDir = "$env:TEMP\Instaladores"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
Set-Location -Path $tempDir

function Download-File {
    param (
        [string]$url,
        [string]$output
    )
    if (Test-Path $output) {
        Remove-Item -Path $output -Force
    }
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $output)
}

function Install-App {
    param (
        [string]$name,
        [string]$url,
        [string]$installerPath,
        [string]$arguments = ""
    )

    Write-Output "🔽 Baixando $name..."
    Download-File -url $url -output $installerPath

    Write-Output "⚙ Instalando $name..."
    try {
        Start-Process -FilePath $installerPath -ArgumentList $arguments -Wait -NoNewWindow
        Write-Output "✅ $name instalado com sucesso."
    } catch {
        Write-Output "❌ Falha ao instalar $name: $_"
    }
}

# Google Chrome
$chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$chromeInstaller = "$tempDir\chrome_installer.exe"
Install-App -name "Google Chrome" -url $chromeUrl -installerPath $chromeInstaller -arguments "/silent /install"

# WinRAR
$winrarUrl = "https://www.rarlab.com/rar/winrar-x64-621br.exe"
$winrarInstaller = "$tempDir\winrar.exe"
Install-App -name "WinRAR" -url $winrarUrl -installerPath $winrarInstaller -arguments "/S"

# AnyDesk
$anydeskUrl = "https://download.anydesk.com/AnyDesk.exe"
$anydeskInstaller = "$tempDir\anydesk.exe"
$anydeskArgs = '--install "C:\Program Files\AnyDesk" --start-with-win --silent'
Install-App -name "AnyDesk" -url $anydeskUrl -installerPath $anydeskInstaller -arguments $anydeskArgs

# Limpeza
Write-Output "🧹 Limpando arquivos temporários..."
Remove-Item -Path $tempDir -Recurse -Force

Write-Output "🏁 Processo concluído!"
