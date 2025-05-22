<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "website_db"; // Altere o nome do banco conforme necessário

// Criar conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Verificar se os dados do formulário foram enviados via POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // Sanitizar os dados recebidos do formulário
    $nome = isset($_POST['nome']) ? htmlspecialchars(trim($_POST['nome'])) : '';
    $email = isset($_POST['email']) ? filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL) : '';
    $telefone = isset($_POST['telefone']) ? htmlspecialchars(trim($_POST['telefone'])) : '';
    $duvida = isset($_POST['duvida']) ? htmlspecialchars(trim($_POST['duvida'])) : '';
    $relato = isset($_POST['relato']) ? htmlspecialchars(trim($_POST['relato'])) : '';

    // Validar se os campos obrigatórios não estão vazios
    if (empty($nome) || empty($email) || empty($telefone) || empty($duvida) || empty($relato)) {
        echo "Por favor, preencha todos os campos obrigatórios!";
        exit;
    }

    // Validar o formato do e-mail
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo "E-mail inválido!";
        exit;
    }

    // Preparar a consulta SQL para evitar SQL Injection
    $stmt = $conn->prepare("INSERT INTO duvidas (nome, email, telefone, duvida, relato) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $nome, $email, $telefone, $duvida, $relato);

    // Tentar executar a consulta
    if ($stmt->execute()) {
        echo "Dúvida enviada com sucesso! Obrigado pelo seu contato.";
    } else {
        // Log de erro em caso de falha
        error_log("Erro ao inserir dúvida: " . $stmt->error);
        echo "Ocorreu um erro ao enviar sua dúvida. Tente novamente mais tarde.";
    }

    // Fechar a declaração preparada e a conexão com o banco de dados
    $stmt->close();
    $conn->close();
}
?>