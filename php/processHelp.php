<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ajuda_webapp";

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$nome = $_POST['nome'];
$email = $_POST['email'];
$duvida = $_POST['duvida'];

$sql = "INSERT INTO duvidas (nome, email, duvida) VALUES ('$nome', '$email', '$duvida')";

if ($conn->query($sql) === TRUE) {
    echo "Dúvida enviada com sucesso!";
} else {
    echo "Erro: " . $sql . "<br>" . $conn->error;
}

$conn->close();