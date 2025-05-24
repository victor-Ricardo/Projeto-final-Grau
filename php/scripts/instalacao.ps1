$tempDir = "$env:TEMP\Instaladores"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
Set-Location -Path $tempDir


function DownloadFile {
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


Write-Output "🔽 Baixando Google Chrome..."
$chromeUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$chromeInstaller = "$tempDir\chrome_installer.exe"
Download-File -url $chromeUrl -output $chromeInstaller

Write-Output "⚙ Instalando Google Chrome..."
Start-Process -FilePath $chromeInstaller -ArgumentList "/silent /install" -Wait -NoNewWindow


Write-Output "🔽 Baixando WinRAR..."
$winrarUrl = "https://www.rarlab.com/rar/winrar-x64-621br.exe"
$winrarInstaller = "$tempDir\winrar.exe"
Download-File -url $winrarUrl -output $winrarInstaller

Write-Output "⚙ Instalando WinRAR..."
Start-Process -FilePath $winrarInstaller -ArgumentList "/S" -Wait -NoNewWindow

Write-Output "🔽 Baixando AnyDesk..."
$anydeskUrl = "https://download.anydesk.com/AnyDesk.exe"
$anydeskInstaller = "$tempDir\anydesk.exe"
Download-File -url $anydeskUrl -output $anydeskInstaller

Write-Output "⚙ Instalando AnyDesk..."
Start-Process -FilePath $anydeskInstaller -ArgumentList "--install `"C:\Program Files\AnyDesk`" --start-with-win --silent" -Wait -NoNewWindow


Write-Output "🧹 Limpando arquivos temporários..."
Remove-Item -Path $tempDir -Recurse -Force

Write-Output "✅ Instalação concluída com sucesso!"

if ($LASTEXITCODE -ne 0) { Write-Output "Erro ao instalar o aplicativo." }