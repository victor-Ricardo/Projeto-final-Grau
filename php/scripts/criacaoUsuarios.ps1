Import-Module ActiveDirectory

# Caminho do CSV
$csvPath = "C:\servidor\usuarios-ad.csv"

# Importa os dados do CSV
$usuarios = Import-Csv -Path $csvPath

foreach ($usuario in $usuarios) {
    $samAccountName = $usuario.SamAccountName
    $nomeCompleto = $usuario.NomeCompleto
    $senha = $usuario.Senha
    $ou = $usuario.OU

    # Converte senha para SecureString
    $secureSenha = ConvertTo-SecureString $senha -AsPlainText -Force

    # Verifica se usuário já existe
    if (Get-ADUser -Filter { SamAccountName -eq $samAccountName } -ErrorAction SilentlyContinue) {
        Write-Warning "Usuário $samAccountName já existe. Pulando..."
        continue
    }

    try {
        New-ADUser `
            -SamAccountName $samAccountName `
            -Name $nomeCompleto `
            -AccountPassword $secureSenha `
            -Enabled $true `
            -Path $ou `
            -ChangePasswordAtLogon $false `
            -PasswordNeverExpires $false

        Write-Host "Usuário $samAccountName criado com sucesso."

    } catch {
        Write-Warning "Erro ao criar usuário $samAccountName: $_"
    }
}
