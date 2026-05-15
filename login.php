<?php
session_start();
require_once 'db_config.php';

// Asegurar que la tabla de usuarios exista (Self-healing)
try {
    $pdo->exec("CREATE TABLE IF NOT EXISTS usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )");
} catch (PDOException $e) {
    // Si falla aquí, probablemente hay un error mayor de conexión
}


$login_error = "";
$register_error = "";
$register_success = "";

if (isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

// Handle Login
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['login'])) {
    $username = trim($_POST['username']);
    $password = $_POST['password'];

    if (!empty($username) && !empty($password)) {
        try {
            $stmt = $pdo->prepare("SELECT id, username, password_hash FROM usuarios WHERE username = ?");
            $stmt->execute([$username]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user && password_verify($password, $user['password_hash'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];
                header("Location: index.php");
                exit();
            } else {
                $login_error = "Usuario o contraseña incorrectos.";
            }
        } catch (PDOException $e) {
            $login_error = "Error de base de datos: " . $e->getMessage();
        }
    } else {
        $login_error = "Por favor, completa todos los campos.";
    }
}

// Handle Registration
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['register'])) {
    $username = trim($_POST['reg_username']);
    $password = $_POST['reg_password'];
    $confirm_password = $_POST['reg_confirm_password'];

    if (!empty($username) && !empty($password) && !empty($confirm_password)) {
        if ($password === $confirm_password) {
            try {
                $stmt = $pdo->prepare("SELECT id FROM usuarios WHERE username = ?");
                $stmt->execute([$username]);
                if ($stmt->fetch()) {
                    $register_error = "El nombre de usuario ya existe.";
                } else {
                    $hash = password_hash($password, PASSWORD_DEFAULT);
                    $stmt = $pdo->prepare("INSERT INTO usuarios (username, password_hash) VALUES (?, ?)");
                    $stmt->execute([$username, $hash]);
                    
                    // Obtener el ID del nuevo usuario para iniciar sesión automáticamente
                    $new_user_id = $pdo->lastInsertId();
                    $_SESSION['user_id'] = $new_user_id;
                    $_SESSION['username'] = $username;
                    
                    header("Location: index.php");
                    exit();

                }
            } catch (PDOException $e) {
                $register_error = "Error de base de datos: " . $e->getMessage();
            }
        } else {
            $register_error = "Las contraseñas no coinciden.";
        }
    } else {
        $register_error = "Por favor, completa todos los campos.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso | Football Central</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .auth-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
            padding: 20px;
        }
        .auth-card {
            width: 100%;
            max-width: 450px;
            overflow: hidden;
            background: rgba(20, 45, 30, 0.95);
            backdrop-filter: blur(10px);
        }
        .auth-nav {
            display: flex;
            background: rgba(0,0,0,0.2);
        }
        .auth-nav button {
            flex: 1;
            padding: 1.2rem;
            border: none;
            background: none;
            color: rgba(255,255,255,0.5);
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            border-bottom: 2px solid transparent;
        }
        .auth-nav button.active {
            color: #57ca85;
            background: rgba(255,255,255,0.05);
            border-bottom: 2px solid #57ca85;
        }
        .auth-body {
            padding: 2.5rem;
        }
        .auth-form {
            display: none;
        }
        .auth-form.active {
            display: block;
            animation: fadeIn 0.4s ease forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .error-box {
            background: hsla(0, 100%, 60%, 0.15);
            color: #ff8a8a;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid rgba(255, 107, 107, 0.3);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            text-align: center;
        }
        .success-box {
            background: hsla(140, 100%, 60%, 0.15);
            color: #8aff8a;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid rgba(107, 255, 107, 0.3);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            text-align: center;
        }
        .btn-submit {
            width: 100%;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Football Central</h1>
            <p>Acceso al Sistema</p>
        </header>

        <div class="auth-container">
            <div class="card auth-card animate-fade">
                <nav class="auth-nav">
                    <button id="login-tab" class="active" onclick="switchTab('login')">INICIAR SESIÓN</button>
                    <button id="register-tab" onclick="switchTab('register')">REGISTRARSE</button>
                </nav>

                <div class="auth-body">
                    <!-- Login Form -->
                    <div id="login-form" class="auth-form active">
                        <?php if ($login_error): ?>
                            <div class="error-box"><?php echo htmlspecialchars($login_error); ?></div>
                        <?php endif; ?>
                        
                        <form method="POST">
                            <input type="hidden" name="login" value="1">
                            <div class="form-group">
                                <label>Usuario</label>
                                <input type="text" name="username" placeholder="ej. administrador" required autofocus>
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" name="password" placeholder="••••••••" required>
                            </div>
                            <button type="submit" class="btn-submit">Entrar al Panel</button>
                        </form>
                    </div>

                    <!-- Register Form -->
                    <div id="register-form" class="auth-form">
                        <?php if ($register_error): ?>
                            <div class="error-box"><?php echo htmlspecialchars($register_error); ?></div>
                        <?php endif; ?>
                        <?php if ($register_success): ?>
                            <div class="success-box"><?php echo htmlspecialchars($register_success); ?></div>
                        <?php endif; ?>

                        <form method="POST">
                            <input type="hidden" name="register" value="1">
                            <div class="form-group">
                                <label>Nuevo Usuario</label>
                                <input type="text" name="reg_username" placeholder="Elige un nombre" required>
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" name="reg_password" placeholder="Mín. 6 caracteres" required>
                            </div>
                            <div class="form-group">
                                <label>Confirmar Contraseña</label>
                                <input type="password" name="reg_confirm_password" placeholder="Repite la contraseña" required>
                            </div>
                            <button type="submit" class="btn-submit">Crear Cuenta</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            const loginForm = document.getElementById('login-form');
            const registerForm = document.getElementById('register-form');
            const loginTab = document.getElementById('login-tab');
            const registerTab = document.getElementById('register-tab');

            if (tab === 'login') {
                loginForm.classList.add('active');
                registerForm.classList.remove('active');
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
            } else {
                loginForm.classList.remove('active');
                registerForm.classList.add('active');
                loginTab.classList.remove('active');
                registerTab.classList.add('active');
            }
        }

        // Si hay errores de registro o éxito, mostrar pestaña de registro al cargar
        <?php if ($register_error || $register_success): ?>
            switchTab('register');
        <?php endif; ?>
    </script>
</body>
</html>
