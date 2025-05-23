<?php
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

        // Executa o script PowerShell e captura a saída
        $command = "powershell -ExecutionPolicy Bypass -File \"$scriptPath\"";
        $output = shell_exec($command);

        // Exibe a saída do script, se existir
        if ($output) {
            echo "Resultado da execução:" . nl2br(htmlspecialchars($output));
        } else {
            echo "O script foi executado, mas não houve saída.";
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
