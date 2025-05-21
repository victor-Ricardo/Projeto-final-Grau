<?php
if (isset($_GET['script'])) {
    $script = $_GET['script'];
    $batFiles = [
        'instalacao' => 'scripts/instalacao.bat',
        'atualizacao' => 'scripts/atualizacao.bat',
        'backup' => 'scripts/backup.bat',
        'limpeza' => 'scripts/limpeza.bat',
        'automacao' => 'scripts/automacao.bat',
        'criacaoUsuarios' => 'scripts/criacaoUsuarios.bat'
    ];

    if (array_key_exists($script, $batFiles)) {
        $output = shell_exec($batFiles[$script]);
        echo "Script '$script' executado com sucesso!";
    } else {
        echo "Script inválido!";
    }
}
?>