# Configurações
$origem = "$env:USERPROFILE\Documents"
$destino = "D:\Backup"  # Altere para a pasta de backup desejada

# Cria a pasta de destino caso não exista
if (-not (Test-Path -Path $destino)) {
    New-Item -ItemType Directory -Path $destino
}

# Data e hora para nomear o backup
$dataHora = Get-Date -Format "yyyyMMdd_HHmmss"

# Nome do arquivo ZIP de backup
$backupZip = "Backup_Documents_$dataHora.zip"

# Caminho completo para salvar o ZIP
$caminhoZip = Join-Path -Path $destino -ChildPath $backupZip

# Criar arquivo zip do diretório de documentos
Compress-Archive -Path "$origem\*" -DestinationPath $caminhoZip -Force

Write-Host "Backup criado com sucesso em $caminhoZip"
