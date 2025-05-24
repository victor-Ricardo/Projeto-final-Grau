<?php
// Caminho completo para o PowerShell
$powershellPath = 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe';

// Define os scripts permitidos com caminhos absolutos
$batFiles = [
    'download'   => __DIR__ . '/scripts/instalacao.ps1',
    'atualizar'  => __DIR__ . '/scripts/atualizacao.ps1',
    'backup'     => __DIR__ . '/scripts/backup.ps1',
    'limpar'     => __DIR__ . '/scripts/limpeza.ps1',
    'automacao'  => __DIR__ . '/scripts/automacao.ps1',
    'usuarios'   => __DIR__ . '/scripts/criacaoUsuarios.ps1'
];

// Verifica se a requisição contém o parâmetro "script"
if (isset($_GET['script'])) {
    $scriptKey = $_GET['script'];

    // Verifica se o script solicitado existe no array permitido
    if (array_key_exists($scriptKey, $batFiles)) {
        $scriptPath = $batFiles[$scriptKey];

        // Garante que o caminho seja absoluto e escapado corretamente
        $escapedScriptPath = escapeshellarg($scriptPath);

        // Monta o comando PowerShell com redirecionamento de erro
        $command = "$powershellPath -ExecutionPolicy Bypass -NoProfile -File $escapedScriptPath 2>&1";

        // Executa e captura a saída
        $output = shell_exec($command);

        // Exibe a saída formatada
        if ($output) {
            echo "<h3>Resultado da execução:</h3><pre>" . htmlspecialchars($output) . "</pre>";
        } else {
            echo "O script foi executado, mas não retornou nenhuma saída.";
        }

    } else {
        http_response_code(400);
        echo "Erro: Script inválido.";
    }
} else {
    http_response_code(400);
    echo "Erro: Nenhum script especificado.";
}
?>

