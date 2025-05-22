<<?php
// Define os scripts permitidos com caminhos absolutos
$batFiles = [
    'download'   => __DIR__ . '/scripts/instalacao.bat',
    'atualizar'  => __DIR__ . '/scripts/atualizacao.bat',
    'backup'     => __DIR__ . '/scripts/backup.bat',
    'limpar'     => __DIR__ . '/scripts/limpeza.bat',
    'automacao'  => __DIR__ . '/scripts/automacao.bat',
    'usuarios'   => __DIR__ . '/scripts/criacaoUsuarios.bat'
];

// Verifica se a requisição contém o parâmetro "script"
if (isset($_GET['script'])) {
    $scriptKey = $_GET['script'];

    // Verifica se o script solicitado existe no array permitido
    if (array_key_exists($scriptKey, $batFiles)) {
        $scriptPath = $batFiles[$scriptKey];

        // Executa o script e captura a saída
        $output = shell_exec("cmd /c \"{$scriptPath}\"");

        // Exibe a saída do script, se existir
        if ($output) {
            echo "Resultado da execução:\n" . nl2br(htmlspecialchars($output));
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