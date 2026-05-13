<?php
session_start();
require_once 'db_config.php';

$error = "";

if (isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
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
                $error = "Usuario o contraseña incorrectos.";
            }
        } catch (PDOException $e) {
            $error = "Error de base de datos: " . $e->getMessage();
        }
    } else {
        $error = "Por favor, completa todos los campos.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión | Football Central</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .login-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 70vh;
        }
        .login-card {
            max-width: 400px;
            width: 100%;
            padding: 2.5rem;
        }
        .login-card form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        .login-card .form-group input {
            width: 100%;
        }
        .login-card .btn-submit {
            width: 100%;
            margin-top: 1rem;
        }
        .error-msg {
            background: hsla(0, 100%, 60%, 0.15);
            color: #ff8a8a;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            border: 1px solid rgba(255, 107, 107, 0.3);
            margin-top: 1.5rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Football Central</h1>
            <p>Acceso Restringido</p>
        </header>

        <div class="login-wrapper">
            <div class="card login-card animate-fade">
                <h2 class="section-title" style="margin-bottom: 0.5rem; justify-content: center;">Iniciar Sesión</h2>
                
                <?php if ($error): ?>
                    <div class="error-msg">
                        <?php echo htmlspecialchars($error); ?>
                    </div>
                <?php endif; ?>

                <form method="POST" action="login.php">
                    <div class="form-group">
                        <label for="username">Usuario</label>
                        <input type="text" name="username" id="username" placeholder="ej. admin" required autofocus>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Contraseña</label>
                        <input type="password" name="password" id="password" placeholder="••••••••" required>
                    </div>

                    <button type="submit" class="btn-submit">Entrar al Panel</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
