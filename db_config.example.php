<?php
/**
 * ARCHIVO DE EJEMPLO DE CONFIGURACIÓN
 * 
 * Instrucciones:
 * 1. Copia este archivo y cámbiale el nombre a 'db_config.php'.
 * 2. Rellena los datos de abajo con tus credenciales de base de datos local.
 * 3. NO subas tu archivo 'db_config.php' real al repositorio (ya está en el .gitignore).
 */

$host = 'localhost';
$dbname = 'nombre_de_tu_base_de_datos';
$username = 'tu_usuario_mysql';
$password = 'tu_contraseña_mysql';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}
?>
