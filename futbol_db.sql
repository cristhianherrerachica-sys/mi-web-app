-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS app_futbol;
USE app_futbol;

-- Crear tabla de equipos
CREATE TABLE IF NOT EXISTS equipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estadio VARCHAR(100),
    anio_fundacion INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla de jugadores relacionadas con la tabla equipos
CREATE TABLE IF NOT EXISTS jugadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    posicion VARCHAR(50),
    dorsal INT,
    equipo_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_equipo
        FOREIGN KEY (equipo_id) 
        REFERENCES equipos(id) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

-- Insertar algunos datos de ejemplo en equipos
INSERT INTO equipos (nombre, ciudad, estadio, anio_fundacion) VALUES
('Real Madrid CF', 'Madrid', 'Santiago Bernabéu', 1902),
('FC Barcelona', 'Barcelona', 'Camp Nou', 1899),
('Atlético de Madrid', 'Madrid', 'Cívitas Metropolitano', 1903),
('Real Betis Balompié', 'Sevilla', 'Benito Villamarín', 1907);

-- Insertar algunos datos de ejemplo en jugadores
INSERT INTO jugadores (nombre, apellidos, posicion, dorsal, equipo_id) VALUES
('Vinícius', 'Júnior', 'Delantero', 7, 1),
('Jude', 'Bellingham', 'Centrocampista', 5, 1),
('Lamine', 'Yamal', 'Delantero', 27, 2),
('Pedri', 'González', 'Centrocampista', 8, 2),
('Antoine', 'Griezmann', 'Delantero', 7, 3),
('Isco', 'Alarcón', 'Centrocampista', 22, 4),
('Héctor', 'Bellerín', 'Defensa', 2, 4),
('Pablo', 'Fornals', 'Centrocampista', 18, 4);

-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar usuario administrador por defecto
-- El hash corresponde a la contraseña "admin123"
INSERT INTO usuarios (username, password_hash) VALUES
('admin', '$2y$10$y5KzBwW.wG1D/M5tC4nUo.l3N6P2oF3z1xQhN9eK1tY3E8.4A2VHe');
