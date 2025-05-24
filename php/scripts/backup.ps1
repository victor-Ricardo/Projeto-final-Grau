# Configurações
$origem = "$env:USERPROFILE\Documents"
$destino = "C:\servidor\Backup"  # Pasta pública com permissões abertas

# Cria a pasta de destino caso não exista
if (-not (Test-Path -Path $destino)) {
    New-Item -ItemType Directory -Path $destino | Out-Null
}

# Data e hora para nomear o backup
$dataHora = Get-Date -Format "yyyyMMdd_HHmmss"

# Nome do arquivo ZIP de backup
$backupZip = "Backup_Documents_$dataHora.zip"

# Caminho completo para salvar o ZIP
$caminhoZip = Join-Path -Path $destino -ChildPath $backupZip

# Criar arquivo zip do diretório de documentos
Compress-Archive -Path "$origem\*" -DestinationPath $caminhoZip -Force

# Saída visível para o PHP
Write-Output "Backup criado com sucesso em $caminhoZip"

