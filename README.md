# ⚽ Football Central | Gestión de Equipos y Jugadores

Football Central es una aplicación web dinámica diseñada para visualizar y gestionar información sobre los equipos y jugadores de La Liga EA Sports. Permite a los administradores registrarse, iniciar sesión y gestionar la base de datos de la liga de forma intuitiva.

## 🚀 Funcionalidades

- **Autenticación Completa**: Sistema de login y registro unificado con cifrado de contraseñas (bcrypt).
- **Visualización de Equipos**: Listado de todos los equipos de primera división con detalles como ciudad, estadio y año de fundación.
- **Gestión de Jugadores**: Formulario para inscribir nuevos jugadores asociados a sus respectivos equipos.
- **Buscador Inteligente**: Filtrado en tiempo real de jugadores por nombre, posición o equipo.
- **Diseño Premium**: Interfaz moderna, responsive y con estética "Dark Mode" inspirada en el fútbol profesional.

## 🛠️ Tecnologías Utilizadas

- **Backend**: [PHP 8.x](https://www.php.net/) con **PDO** para una conexión segura a la base de datos.
- **Base de Datos**: [MySQL](https://www.mysql.com/) / MariaDB.
- **Frontend**: 
    - **HTML5** Semántico.
    - **CSS3** (Variables, Grid, Flexbox y animaciones personalizadas).
    - **JavaScript** (Vanilla script para filtrado dinámico y efectos visuales).
- **Servidor Recomendado**: XAMPP / Apache.

## 📥 Instalación

Sigue estos pasos para poner la aplicación en marcha en tu entorno local:

1. **Clonar el proyecto**:
   Copia todos los archivos dentro de tu carpeta `htdocs` (si usas XAMPP).

2. **Configurar la Base de Datos**:
   - Crea una base de datos llamada `app_futbol`.
   - Modifica el archivo `db_config.php` con tus credenciales de MySQL (host, usuario, contraseña).
   - Importa el archivo `futbol_db.sql` en PHPMyAdmin para cargar los datos iniciales de los equipos.

3. **Acceso al Panel**:
   - Abre tu navegador y dirígete a `http://localhost/login.php`.
   - Si no tienes cuenta, usa la pestaña de **Registro** para crear una. El sistema creará automáticamente la tabla de usuarios si no existe.

## 🌐 Despliegue

Puedes ver la versión en línea de este proyecto aquí:
🔗 **[Football Central en dwes.site](http://dwes.site)**

---
*Desarrollado como proyecto de gestión de bases de datos y desarrollo web.*