# Limpa arquivos temporários do usuário
Write-Host "Limpando arquivos temporários do usuário..."
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpa arquivos temporários do sistema
Write-Host "Limpando arquivos temporários do sistema..."
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpa a pasta Prefetch (opcional)
Write-Host "Limpando pasta Prefetch..."
Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpa a lixeira
Write-Host "Esvaziando lixeira..."
Remove-Item -Path "C:\$Recycle.Bin\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpa logs do Windows
Write-Host "Limpando logs do Windows..."
try {
    wevtutil el | ForEach-Object { 
        wevtutil cl $_ 
    }
} catch {
    Write-Warning "Falha ao limpar alguns logs do Windows: $_"
}

# Limpa dados do Google Chrome
Write-Host "Limpando dados do Google Chrome..."

$chromeProfile = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"
$chromeCache = Join-Path $chromeProfile "Cache"
$chromeCookies = Join-Path $chromeProfile "Cookies"
$chromeHistory = Join-Path $chromeProfile "History"
$chromeLocalStorage = Join-Path $chromeProfile "Local Storage"

if (Test-Path $chromeCache) {
    Remove-Item -Path "$chromeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path $chromeCookies) {
    Remove-Item -Path $chromeCookies -Force -ErrorAction SilentlyContinue
}
if (Test-Path $chromeHistory) {
    Remove-Item -Path $chromeHistory -Force -ErrorAction SilentlyContinue
}
if (Test-Path $chromeLocalStorage) {
    Remove-Item -Path "$chromeLocalStorage\*" -Recurse -Force -ErrorAction SilentlyContinue
}

# Limpa dados do Microsoft Edge
Write-Host "Limpando dados do Microsoft Edge..."

$edgeProfile = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default"
$edgeCache = Join-Path $edgeProfile "Cache"
$edgeCookies = Join-Path $edgeProfile "Cookies"
$edgeHistory = Join-Path $edgeProfile "History"
$edgeLocalStorage = Join-Path $edgeProfile "Local Storage"

if (Test-Path $edgeCache) {
    Remove-Item -Path "$edgeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path $edgeCookies) {
    Remove-Item -Path $edgeCookies -Force -ErrorAction SilentlyContinue
}
if (Test-Path $edgeHistory) {
    Remove-Item -Path $edgeHistory -Force -ErrorAction SilentlyContinue
}
if (Test-Path $edgeLocalStorage) {
    Remove-Item -Path "$edgeLocalStorage\*" -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "`n✔️ Limpeza concluída com sucesso!"
