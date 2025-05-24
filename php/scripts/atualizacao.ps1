# Início do log
$logPath = "$env:TEMP\log-atualizacao-softwares.txt"
Start-Transcript -Path $logPath -Append

# Caminho da pasta de instaladores (pode ser rede ou local)
$sourcePath = "C:\servidor\instaladores"

# Lista de softwares manuais com instaladores
$softwares = @(
    @{
        Nome = "Google Chrome"
        Executavel = "ChromeSetup.exe"
        Parametros = "/silent /install"
    },
    @{
        Nome = "WinRAR"
        Executavel = "winrar-x64-620br.exe"
        Parametros = "/S"
    },
    @{
        Nome = "AnyDesk"
        Executavel = "AnyDesk.exe"
        Parametros = "--install --silent"
    }
)

# Função para instalar software manual
function Instalar-Software($nome, $arquivo, $parametros) {
    $caminho = Join-Path $sourcePath $arquivo
    Write-Host "`n>> Instalando $nome..."

    if (Test-Path $caminho) {
        try {
            Start-Process -FilePath $caminho -ArgumentList $parametros -Wait -NoNewWindow
            Write-Host "✔ $nome instalado com sucesso."
        } catch {
            Write-Warning "Erro ao instalar $nome: $_"
        }
    } else {
        Write-Warning "Arquivo não encontrado: $caminho"
    }
}

# Executa a instalação para cada software manual
foreach ($software in $softwares) {
    Instalar-Software -nome $software.Nome -arquivo $software.Executavel -parametros $software.Parametros
}

# Atualiza os aplicativos nativos da Microsoft Store via winget
Write-Host "`n>> Atualizando aplicativos nativos do Windows..."
try {
    winget upgrade --all --silent
    Write-Host "✔ Aplicativos da Microsoft Store atualizados com sucesso."
} catch {
    Write-Warning "Erro ao atualizar aplicativos nativos: $_"
}

# Finaliza
Write-Host "`n✅ Atualização de softwares concluída."
Stop-Transcript
