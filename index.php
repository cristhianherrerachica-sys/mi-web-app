<?php
header('Content-Type: text/html; charset=utf-8');
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

require_once 'db_config.php';

// Handle Form Submission
$message = "";
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'register_player') {
    $nombre = $_POST['nombre'];
    $apellidos = $_POST['apellidos'];
    $posicion = $_POST['posicion'];
    $dorsal = (int)$_POST['dorsal'];
    $equipo_id = (int)$_POST['equipo_id'];

    try {
        $stmt = $pdo->prepare("INSERT INTO jugadores (nombre, apellidos, posicion, dorsal, equipo_id) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$nombre, $apellidos, $posicion, $dorsal, $equipo_id]);
        $message = "¡Jugador " . htmlspecialchars($nombre) . " inscrito con éxito!";
    } catch (PDOException $e) {
        $message = "Error al inscribir: " . $e->getMessage();
    }
}

// Handle Deletion
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'delete_player') {
    $player_id = (int)$_POST['player_id'];

    try {
        $stmt = $pdo->prepare("DELETE FROM jugadores WHERE id = ?");
        $stmt->execute([$player_id]);
        $message = "Jugador eliminado correctamente.";
    } catch (PDOException $e) {
        $message = "Error al eliminar: " . $e->getMessage();
    }
}

// Fetch Teams
$stmtTeams = $pdo->query("SELECT * FROM equipos ORDER BY nombre");
$teams = $stmtTeams->fetchAll(PDO::FETCH_ASSOC);

// Fetch Players with Team Name
$stmtPlayers = $pdo->query("SELECT j.*, e.nombre as equipo_nombre FROM jugadores j LEFT JOIN equipos e ON j.equipo_id = e.id ORDER BY j.id DESC");
$players = $stmtPlayers->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Football Dash | Central PHP</title>
    <meta name="description" content="Visualiza todos los datos de equipos y jugadores de la liga.">
    <link rel="stylesheet" href="style.css?v=1.1">
</head>
<body>
    <div class="container">
        <header style="position: relative;">
            <h1>Football Central</h1>
            <p>Panel de Gestión y Visualización de la Base de Datos (PHP Version)</p>
            <div style="position: absolute; top: 0; right: 0;">
                <span style="font-size: 0.85rem; color: var(--text-muted); margin-right: 15px;">Hola, <?php echo htmlspecialchars($_SESSION['username']); ?></span>
                <a href="logout.php" style="color: white; text-decoration: none; font-size: 0.85rem; background: rgba(255,107,107,0.2); border: 1px solid rgba(255,107,107,0.5); padding: 6px 12px; border-radius: 8px; transition: var(--transition-smooth);">Cerrar Sesión</a>
            </div>
        </header>

        <?php if ($message): ?>
            <div id="php-alert" class="card shadow" style="margin-bottom: 2rem; border-color: var(--accent-primary); text-align: center;">
                <p style="color: var(--accent-primary); font-weight: 600;"><?php echo $message; ?></p>
            </div>
            <script>setTimeout(() => { document.getElementById('php-alert').style.display = 'none'; }, 5000);</script>
        <?php endif; ?>

        <section id="teams-section">
            <h2 class="section-title">Equipos de la Liga</h2>
            <div id="teams-grid" class="teams-grid">
                <?php foreach ($teams as $team): ?>
                    <div class="card animate-fade">
                        <h3><?php echo htmlspecialchars($team['nombre']); ?></h3>
                        <div class="card-info">
                            <span>📍 <?php echo htmlspecialchars($team['ciudad']); ?></span>
                            <span>🏟️ <?php echo htmlspecialchars($team['estadio']); ?></span>
                            <span>📅 Est. <?php echo htmlspecialchars($team['anio_fundacion']); ?></span>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>

        <section id="registration-section" class="registration-section">
            <h2 class="section-title">Inscripción de Jugadores</h2>
            <div class="registration-container animate-fade">
                <form id="player-form-php" class="registration-form" method="POST" action="index.php">
                    <input type="hidden" name="action" value="register_player">
                    <div class="form-group">
                        <label for="reg-name">Nombre</label>
                        <input type="text" name="nombre" id="reg-name" placeholder="Ej: Kylian" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-surname">Apellidos</label>
                        <input type="text" name="apellidos" id="reg-surname" placeholder="Ej: Mbappé" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-pos">Posición</label>
                        <select name="posicion" id="reg-pos" required>
                            <option value="" disabled selected>Seleccionar...</option>
                            <option value="Portero">Portero</option>
                            <option value="Defensa">Defensa</option>
                            <option value="Centrocampista">Centrocampista</option>
                            <option value="Delantero">Delantero</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="reg-dorsal">Dorsal</label>
                        <input type="number" name="dorsal" id="reg-dorsal" placeholder="1-99" min="1" max="99" required>
                    </div>
                    <div class="form-group">
                        <label for="reg-team">Equipo</label>
                        <select name="equipo_id" id="reg-team" required>
                            <option value="" disabled selected>Seleccionar equipo...</option>
                            <?php foreach ($teams as $team): ?>
                                <option value="<?php echo $team['id']; ?>"><?php echo htmlspecialchars($team['nombre']); ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn-submit">Inscribir Jugador</button>
                    </div>
                </form>
            </div>
        </section>

        <section id="players-section">
            <h2 class="section-title">Gestión de Jugadores</h2>
            <div class="controls">
                <p style="color: var(--text-muted); margin-bottom: 1rem;">Desde aquí puedes buscar y dar de baja a los jugadores inscritos en el sistema.</p>
                <div class="search-wrapper">
                    <input type="text" id="playerSearch" placeholder="Buscar jugador, posición o equipo...">
                </div>
            </div>
            
            <div class="players-container animate-fade">
                <table id="players-table">
                    <thead>
                        <tr>
                            <th>Dorsal</th>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Posición</th>
                            <th>Equipo</th>
                            <th style="text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="players-body">
                        <?php foreach ($players as $player): ?>
                            <tr>
                                <td><div class="dorsal-circle"><?php echo $player['dorsal']; ?></div></td>
                                <td><strong><?php echo htmlspecialchars($player['nombre']); ?></strong></td>
                                <td><?php echo htmlspecialchars($player['apellidos']); ?></td>
                                <td>
                                    <?php 
                                        $pos = $player['posicion'];
                                        $short = '??'; $class = '';
                                        if (strpos($pos, 'Delantero') !== false) { $short = 'FW'; $class = 'pos-FW'; }
                                        elseif (strpos($pos, 'Centrocampista') !== false) { $short = 'MF'; $class = 'pos-MF'; }
                                        elseif (strpos($pos, 'Defensa') !== false) { $short = 'DF'; $class = 'pos-DF'; }
                                        elseif (strpos($pos, 'Portero') !== false) { $short = 'GK'; $class = 'pos-GK'; }
                                    ?>
                                    <span class="pos-tag <?php echo $class; ?>"><?php echo $short; ?></span> <?php echo htmlspecialchars($pos); ?>
                                </td>
                                <td><?php echo htmlspecialchars($player['equipo_nombre'] ?: 'Sin equipo'); ?></td>
                                <td style="text-align: center;">
                                    <form method="POST" action="index.php" onsubmit="return confirm('¿Estás seguro de que deseas eliminar a este jugador?');" style="display: inline;">
                                        <input type="hidden" name="action" value="delete_player">
                                        <input type="hidden" name="player_id" value="<?php echo $player['id']; ?>">
                                        <button type="submit" class="btn-delete">
                                            🗑️ Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </section>
    </div>

    <script src="app.js"></script>
</body>
</html>
