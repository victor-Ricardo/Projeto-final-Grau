# Define os caminhos
$sourcePath = "C:\logs\*"
$backupPath = "C:\logs-backup\"

# Verifica se a pasta de backup existe, se não, cria
if (-not (Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

# Move todos os arquivos e pastas de logs para a pasta de backup
Move-Item -Path $sourcePath -Destination $backupPath -Force

# Agenda o desligamento do computador para daqui a 10 minutos (600 segundos)
shutdown.exe /s /t 600 /c "Desligamento agendado após backup dos logs."
