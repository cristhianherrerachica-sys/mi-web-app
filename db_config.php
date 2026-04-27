<?php
// Configuración de la base de datos
$host = 'localhost';
$dbname = 'app_futbol';
$username = 'root';
$password = ''; // Cambiar si tienes contraseña en tu MySQL

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    // Configurar el modo de error de PDO para que lance excepciones
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}
?>
