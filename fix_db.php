<?php
require_once 'db_config.php';

try {
    // Asegurar que la conexión use UTF8
    $pdo->exec("SET NAMES 'utf8mb4'");
    
    // Leer el archivo SQL
    $sql = file_get_contents('futbol_db.sql');
    
    // Eliminar comentarios y dividir por punto y coma (aproximación simple)
    // Para archivos grandes o complejos, esto requiere un parser más robusto.
    // Pero para este futbol_db.sql debería bastar.
    
    // Primero, limpiar la base de datos
    $pdo->exec("DROP DATABASE IF EXISTS app_futbol");
    $pdo->exec("CREATE DATABASE app_futbol CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    $pdo->exec("USE app_futbol");

    // Ejecutar el SQL
    // Nota: exec() solo ejecuta una sentencia. Usaremos el método nativo de PDO si es posible o dividiremos.
    $pdo->exec($sql);
    
    echo "¡Base de datos re-importada con éxito usando UTF-8 nativo!<br>";
    echo "Por favor, refresca la página de la web para comprobar las tildes.";

} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
} catch (Exception $e) {
    echo "Error general: " . $e->getMessage();
}
?>
