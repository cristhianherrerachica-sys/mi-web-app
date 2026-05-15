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

-- Insertar todos los equipos de La Liga EA Sports
INSERT INTO equipos (nombre, ciudad, estadio, anio_fundacion) VALUES
('Real Madrid CF', 'Madrid', 'Santiago Bernabéu', 1902),
('FC Barcelona', 'Barcelona', 'Camp Nou', 1899),
('Atlético de Madrid', 'Madrid', 'Cívitas Metropolitano', 1903),
('Athletic Club', 'Bilbao', 'San Mamés', 1898),
('Real Sociedad', 'San Sebastián', 'Reale Arena', 1909),
('Villarreal CF', 'Vila-real', 'Estadio de la Cerámica', 1923),
('Real Betis Balompié', 'Sevilla', 'Benito Villamarín', 1907),
('Valencia CF', 'Valencia', 'Mestalla', 1919),
('Sevilla FC', 'Sevilla', 'Ramón Sánchez-Pizjuán', 1890),
('CA Osasuna', 'Pamplona', 'El Sadar', 1920),
('RC Celta de Vigo', 'Vigo', 'Abanca Balaídos', 1923),
('RCD Mallorca', 'Palma de Mallorca', 'Estadi Mallorca Son Moix', 1916),
('Deportivo Alavés', 'Vitoria-Gasteiz', 'Mendizorroza', 1921),
('Girona FC', 'Girona', 'Montilivi', 1930),
('Rayo Vallecano', 'Madrid', 'Estadio de Vallecas', 1924),
('UD Las Palmas', 'Las Palmas de GC', 'Estadio de Gran Canaria', 1949),
('CD Leganés', 'Leganés', 'Estadio Municipal Butarque', 1928),
('Getafe CF', 'Getafe', 'Coliseum', 1946),
('Real Valladolid CF', 'Valladolid', 'Estadio José Zorrilla', 1928),
('RCD Espanyol', 'Barcelona', 'Stage Front Stadium', 1900);

-- Insertar plantillas (15 jugadores por equipo) para la liga EA Sports
INSERT INTO jugadores (nombre, apellidos, posicion, dorsal, equipo_id) VALUES
-- Real Madrid CF (1)
('Thibaut', 'Courtois', 'Portero', 1, 1), ('Dani', 'Carvajal', 'Defensa', 2, 1), ('Éder', 'Militão', 'Defensa', 3, 1), ('Antonio', 'Rüdiger', 'Defensa', 22, 1), ('Ferland', 'Mendy', 'Defensa', 23, 1), ('Aurélien', 'Tchouaméni', 'Centrocampista', 14, 1), ('Federico', 'Valverde', 'Centrocampista', 8, 1), ('Jude', 'Bellingham', 'Centrocampista', 5, 1), ('Rodrygo', 'Goes', 'Delantero', 11, 1), ('Vinícius', 'Júnior', 'Delantero', 7, 1), ('Kylian', 'Mbappé', 'Delantero', 9, 1), ('Eduardo', 'Camavinga', 'Centrocampista', 6, 1), ('Andriy', 'Lunin', 'Portero', 13, 1), ('Brahim', 'Díaz', 'Delantero', 21, 1), ('Luka', 'Modrić', 'Centrocampista', 10, 1),
-- FC Barcelona (2)
('Marc-André', 'ter Stegen', 'Portero', 1, 2), ('Jules', 'Koundé', 'Defensa', 23, 2), ('Ronald', 'Araújo', 'Defensa', 4, 2), ('Pau', 'Cubarsí', 'Defensa', 2, 2), ('Alejandro', 'Balde', 'Defensa', 3, 2), ('Gavi', 'Páez', 'Centrocampista', 6, 2), ('Pedri', 'González', 'Centrocampista', 8, 2), ('Frenkie', 'de Jong', 'Centrocampista', 21, 2), ('Lamine', 'Yamal', 'Delantero', 19, 2), ('Robert', 'Lewandowski', 'Delantero', 9, 2), ('Raphinha', 'Dias', 'Delantero', 11, 2), ('Fermín', 'López', 'Centrocampista', 16, 2), ('Iñaki', 'Peña', 'Portero', 13, 2), ('Andreas', 'Christensen', 'Defensa', 15, 2), ('Ferran', 'Torres', 'Delantero', 7, 2),
-- Atlético de Madrid (3)
('Jan', 'Oblak', 'Portero', 13, 3), ('Marcos', 'Llorente', 'Defensa', 14, 3), ('José', 'Giménez', 'Defensa', 2, 3), ('Robin', 'Le Normand', 'Defensa', 24, 3), ('César', 'Azpilicueta', 'Defensa', 3, 3), ('Koke', 'Resurrección', 'Centrocampista', 6, 3), ('Rodrigo', 'De Paul', 'Centrocampista', 5, 3), ('Samuel', 'Lino', 'Centrocampista', 12, 3), ('Antoine', 'Griezmann', 'Delantero', 7, 3), ('Julián', 'Álvarez', 'Delantero', 19, 3), ('Alexander', 'Sørloth', 'Delantero', 9, 3), ('Ángel', 'Correa', 'Delantero', 10, 3), ('Pablo', 'Barrios', 'Centrocampista', 8, 3), ('Nahuel', 'Molina', 'Defensa', 16, 3), ('Axel', 'Witsel', 'Defensa', 20, 3),
-- Athletic Club (4)
('Unai', 'Simón', 'Portero', 1, 4), ('Óscar', 'de Marcos', 'Defensa', 18, 4), ('Dani', 'Vivian', 'Defensa', 3, 4), ('Aitor', 'Paredes', 'Defensa', 4, 4), ('Yuri', 'Berchiche', 'Defensa', 17, 4), ('Mikel', 'Vesga', 'Centrocampista', 6, 4), ('Beñat', 'Prados', 'Centrocampista', 24, 4), ('Oihan', 'Sancet', 'Centrocampista', 8, 4), ('Iñaki', 'Williams', 'Delantero', 9, 4), ('Nico', 'Williams', 'Delantero', 10, 4), ('Gorka', 'Guruzeta', 'Delantero', 12, 4), ('Julen', 'Agirrezabala', 'Portero', 13, 4), ('Iñigo', 'Lekue', 'Defensa', 15, 4), ('Álvaro', 'Djaló', 'Delantero', 11, 4), ('Ander', 'Herrera', 'Centrocampista', 21, 4),
-- Real Sociedad (5)
('Álex', 'Remiro', 'Portero', 1, 5), ('Hamari', 'Traoré', 'Defensa', 21, 5), ('Igor', 'Zubeldia', 'Defensa', 5, 5), ('Jon', 'Pacheco', 'Defensa', 20, 5), ('Javi', 'López', 'Defensa', 12, 5), ('Martín', 'Zubimendi', 'Centrocampista', 4, 5), ('Beñat', 'Turrientes', 'Centrocampista', 22, 5), ('Brais', 'Méndez', 'Centrocampista', 23, 5), ('Takefusa', 'Kubo', 'Delantero', 14, 5), ('Mikel', 'Oyarzabal', 'Delantero', 10, 5), ('Sheraldo', 'Becker', 'Delantero', 11, 5), ('Aritz', 'Elustondo', 'Defensa', 6, 5), ('Ander', 'Barrenetxea', 'Delantero', 7, 5), ('Luka', 'Sučić', 'Centrocampista', 24, 5), ('Sergio', 'Gómez', 'Delantero', 17, 5),
-- Villarreal CF (6)
('Diego', 'Conde', 'Portero', 13, 6), ('Kiko', 'Femenía', 'Defensa', 17, 6), ('Raúl', 'Albiol', 'Defensa', 3, 6), ('Eric', 'Bailly', 'Defensa', 4, 6), ('Sergi', 'Cardona', 'Defensa', 12, 6), ('Dani', 'Parejo', 'Centrocampista', 10, 6), ('Santi', 'Comesaña', 'Centrocampista', 14, 6), ('Álex', 'Baena', 'Centrocampista', 16, 6), ('Yeremy', 'Pino', 'Delantero', 21, 6), ('Gerard', 'Moreno', 'Delantero', 7, 6), ('Ayoze', 'Pérez', 'Delantero', 22, 6), ('Luiz', 'Júnior', 'Portero', 1, 6), ('Pape', 'Gueye', 'Centrocampista', 20, 6), ('Denis', 'Suárez', 'Centrocampista', 6, 6), ('Ilias', 'Akhomach', 'Delantero', 11, 6),
-- Real Betis Balompié (7)
('Rui', 'Silva', 'Portero', 1, 7), ('Héctor', 'Bellerín', 'Defensa', 2, 7), ('Diego', 'Llorente', 'Defensa', 3, 7), ('Marc', 'Bartra', 'Defensa', 5, 7), ('Romain', 'Perraud', 'Defensa', 15, 7), ('Marc', 'Roca', 'Centrocampista', 21, 7), ('William', 'Carvalho', 'Centrocampista', 14, 7), ('Pablo', 'Fornals', 'Centrocampista', 8, 7), ('Isco', 'Alarcón', 'Centrocampista', 22, 7), ('Ez', 'Abde', 'Delantero', 10, 7), ('Chimy', 'Ávila', 'Delantero', 9, 7), ('Adrián', 'San Miguel', 'Portero', 25, 7), ('Johnny', 'Cardoso', 'Centrocampista', 4, 7), ('Aitor', 'Ruibal', 'Defensa', 24, 7), ('Vitor', 'Roque', 'Delantero', 19, 7),
-- Valencia CF (8)
('Giorgi', 'Mamardashvili', 'Portero', 25, 8), ('Thierry', 'Correia', 'Defensa', 20, 8), ('Cristhian', 'Mosquera', 'Defensa', 3, 8), ('César', 'Tárrega', 'Defensa', 12, 8), ('Jesús', 'Vázquez', 'Defensa', 21, 8), ('Pepelu', 'García', 'Centrocampista', 18, 8), ('Javi', 'Guerra', 'Centrocampista', 8, 8), ('André', 'Almeida', 'Centrocampista', 10, 8), ('Diego', 'López', 'Delantero', 16, 8), ('Luis', 'Rioja', 'Delantero', 22, 8), ('Hugo', 'Duro', 'Delantero', 9, 8), ('Stole', 'Dimitrievski', 'Portero', 1, 8), ('Hugo', 'Guillamón', 'Centrocampista', 6, 8), ('Sergi', 'Canós', 'Delantero', 7, 8), ('Rafa', 'Mir', 'Delantero', 11, 8),
-- Sevilla FC (9)
('Ørjan', 'Nyland', 'Portero', 13, 9), ('José Ángel', 'Carmona', 'Defensa', 32, 9), ('Loïc', 'Badé', 'Defensa', 22, 9), ('Kike', 'Salas', 'Defensa', 2, 9), ('Adrià', 'Pedrosa', 'Defensa', 3, 9), ('Nemanja', 'Gudelj', 'Centrocampista', 6, 9), ('Djibril', 'Sow', 'Centrocampista', 20, 9), ('Chidera', 'Ejuke', 'Delantero', 21, 9), ('Saúl', 'Ñíguez', 'Centrocampista', 17, 9), ('Dodi', 'Lukebakio', 'Delantero', 11, 9), ('Isaac', 'Romero', 'Delantero', 14, 9), ('Álvaro', 'Fernández', 'Portero', 1, 9), ('Suso', 'Fernández', 'Delantero', 7, 9), ('Jesús', 'Navas', 'Defensa', 16, 9), ('Juanlu', 'Sánchez', 'Centrocampista', 26, 9),
-- CA Osasuna (10)
('Sergio', 'Herrera', 'Portero', 1, 10), ('Jesús', 'Areso', 'Defensa', 12, 10), ('Alejandro', 'Catena', 'Defensa', 24, 10), ('Enzo', 'Boyomo', 'Defensa', 22, 10), ('Abel', 'Bretones', 'Defensa', 23, 10), ('Lucas', 'Torró', 'Centrocampista', 24, 10), ('Jon', 'Moncayola', 'Centrocampista', 7, 10), ('Aimar', 'Oroz', 'Centrocampista', 10, 10), ('Rubén', 'García', 'Centrocampista', 14, 10), ('Bryan', 'Zaragoza', 'Delantero', 19, 10), ('Ante', 'Budimir', 'Delantero', 17, 10), ('Aitor', 'Fernández', 'Portero', 13, 10), ('Jorge', 'Herrando', 'Defensa', 28, 10), ('Moi', 'Gómez', 'Centrocampista', 16, 10), ('Raúl', 'García', 'Delantero', 20, 10),
-- RC Celta de Vigo (11)
('Vicente', 'Guaita', 'Portero', 13, 11), ('Óscar', 'Mingueza', 'Defensa', 3, 11), ('Carl', 'Starfelt', 'Defensa', 2, 11), ('Jailson', 'Marques', 'Defensa', 16, 11), ('Hugo', 'Álvarez', 'Defensa', 30, 11), ('Fran', 'Beltrán', 'Centrocampista', 8, 11), ('Ilaix', 'Moriba', 'Centrocampista', 6, 11), ('Jonathan', 'Bamba', 'Delantero', 17, 11), ('Iago', 'Aspas', 'Delantero', 10, 11), ('Williot', 'Swedberg', 'Centrocampista', 19, 11), ('Borja', 'Iglesias', 'Delantero', 7, 11), ('Iván', 'Villar', 'Portero', 1, 11), ('Javier', 'Manquillo', 'Defensa', 22, 11), ('Hugo', 'Sotelo', 'Centrocampista', 33, 11), ('Anastasios', 'Douvikas', 'Delantero', 9, 11),
-- RCD Mallorca (12)
('Dominik', 'Greif', 'Portero', 13, 12), ('Pablo', 'Maffeo', 'Defensa', 3, 12), ('Martin', 'Valjent', 'Defensa', 24, 12), ('Antonio', 'Raíllo', 'Defensa', 21, 12), ('Johan', 'Mojica', 'Defensa', 22, 12), ('Samú', 'Costa', 'Centrocampista', 12, 12), ('Omar', 'Mascarell', 'Centrocampista', 5, 12), ('Sergi', 'Darder', 'Centrocampista', 10, 12), ('Dani', 'Rodríguez', 'Centrocampista', 14, 12), ('Takuma', 'Asano', 'Delantero', 11, 12), ('Vedat', 'Muriqi', 'Delantero', 7, 12), ('Leo', 'Román', 'Portero', 1, 12), ('Copete', 'José', 'Defensa', 6, 12), ('Robert', 'Navarro', 'Centrocampista', 20, 12), ('Cyle', 'Larin', 'Delantero', 17, 12),
-- Deportivo Alavés (13)
('Antonio', 'Sivera', 'Portero', 1, 13), ('Nahuel', 'Tenaglia', 'Defensa', 14, 13), ('Abdel', 'Abqar', 'Defensa', 5, 13), ('Aleksandar', 'Sedlar', 'Defensa', 4, 13), ('Manu', 'Sánchez', 'Defensa', 22, 13), ('Antonio', 'Blanco', 'Centrocampista', 8, 13), ('Ander', 'Guevara', 'Centrocampista', 6, 13), ('Jon', 'Guridi', 'Centrocampista', 18, 13), ('Carlos', 'Vicente', 'Delantero', 21, 13), ('Tomás', 'Conechny', 'Delantero', 11, 13), ('Kike', 'García', 'Delantero', 15, 13), ('Jesús', 'Owono', 'Portero', 31, 13), ('Moussa', 'Diarra', 'Defensa', 12, 13), ('Joan', 'Jordán', 'Centrocampista', 24, 13), ('Toni', 'Martínez', 'Delantero', 19, 13),
-- Girona FC (14)
('Paulo', 'Gazzaniga', 'Portero', 13, 14), ('Alejandro', 'Francés', 'Defensa', 16, 14), ('David', 'López', 'Defensa', 5, 14), ('Daley', 'Blind', 'Defensa', 17, 14), ('Miguel', 'Gutiérrez', 'Defensa', 3, 14), ('Oriol', 'Romeu', 'Centrocampista', 14, 14), ('Yangel', 'Herrera', 'Centrocampista', 21, 14), ('Iván', 'Martín', 'Centrocampista', 23, 14), ('Viktor', 'Tsygankov', 'Delantero', 8, 14), ('Bryan', 'Gil', 'Delantero', 20, 14), ('Abel', 'Ruiz', 'Delantero', 9, 14), ('Pau', 'López', 'Portero', 1, 14), ('Arnau', 'Martínez', 'Defensa', 4, 14), ('Donny', 'van de Beek', 'Centrocampista', 6, 14), ('Bojan', 'Miovski', 'Delantero', 19, 14),
-- Rayo Vallecano (15)
('Dani', 'Cárdenas', 'Portero', 1, 15), ('Andrei', 'Rațiu', 'Defensa', 2, 15), ('Florian', 'Lejeune', 'Defensa', 24, 15), ('Abdul', 'Mumin', 'Defensa', 16, 15), ('Pep', 'Chavarría', 'Defensa', 3, 15), ('Óscar', 'Valentín', 'Centrocampista', 23, 15), ('Pathé', 'Ciss', 'Centrocampista', 21, 15), ('Isi', 'Palazón', 'Centrocampista', 7, 15), ('Jorge', 'de Frutos', 'Centrocampista', 19, 15), ('Álvaro', 'García', 'Delantero', 18, 15), ('Sergio', 'Camello', 'Delantero', 14, 15), ('Augusto', 'Batalla', 'Portero', 13, 15), ('Alfonso', 'Espino', 'Defensa', 12, 15), ('James', 'Rodríguez', 'Centrocampista', 10, 15), ('Raúl', 'de Tomás', 'Delantero', 11, 15),
-- UD Las Palmas (16)
('Jasper', 'Cillessen', 'Portero', 1, 16), ('Álex', 'Suárez', 'Defensa', 4, 16), ('Scott', 'McKenna', 'Defensa', 15, 16), ('Mika', 'Mármol', 'Defensa', 3, 16), ('Xavi', 'Muñoz', 'Defensa', 23, 16), ('Kirian', 'Rodríguez', 'Centrocampista', 20, 16), ('José', 'Campaña', 'Centrocampista', 8, 16), ('Alberto', 'Moleiro', 'Centrocampista', 10, 16), ('Sandro', 'Ramírez', 'Delantero', 19, 16), ('Oliver', 'McBurnie', 'Delantero', 16, 16), ('Jaime', 'Mata', 'Delantero', 21, 16), ('Álvaro', 'Valles', 'Portero', 13, 16), ('Marvin', 'Park', 'Defensa', 2, 16), ('Javier', 'Muñoz', 'Centrocampista', 5, 16), ('Marc', 'Cardona', 'Delantero', 7, 16),
-- CD Leganés (17)
('Juan', 'Soriano', 'Portero', 13, 17), ('Valentin', 'Rosier', 'Defensa', 2, 17), ('Jorge', 'Sáenz', 'Defensa', 3, 17), ('Sergio', 'González', 'Defensa', 22, 17), ('Javi', 'Hernández', 'Defensa', 20, 17), ('Yvan', 'Neyou', 'Centrocampista', 17, 17), ('Darko', 'Brašanac', 'Centrocampista', 8, 17), ('Seydouba', 'Cissé', 'Centrocampista', 24, 17), ('Juan', 'Cruz', 'Delantero', 11, 17), ('Enric', 'Franquesa', 'Defensa', 15, 17), ('Sébastien', 'Haller', 'Delantero', 18, 17), ('Marko', 'Dmitrović', 'Portero', 1, 17), ('Óscar', 'Rodríguez', 'Centrocampista', 7, 17), ('Dani', 'Raba', 'Delantero', 10, 17), ('Miguel', 'de la Fuente', 'Delantero', 9, 17),
-- Getafe CF (18)
('David', 'Soria', 'Portero', 13, 18), ('Juan', 'Iglesias', 'Defensa', 21, 18), ('Djené', 'Dakonam', 'Defensa', 2, 18), ('Omar', 'Alderete', 'Defensa', 15, 18), ('Diego', 'Rico', 'Defensa', 16, 18), ('Luis', 'Milla', 'Centrocampista', 5, 18), ('Mauro', 'Arambarri', 'Centrocampista', 18, 18), ('Chrisantus', 'Uche', 'Centrocampista', 6, 18), ('Carles', 'Pérez', 'Delantero', 17, 18), ('Álex', 'Sola', 'Centrocampista', 7, 18), ('Bertuğ', 'Yıldırım', 'Delantero', 9, 18), ('Jiří', 'Letáček', 'Portero', 1, 18), ('Domingos', 'Duarte', 'Defensa', 22, 18), ('Peter', 'Federico', 'Centrocampista', 11, 18), ('Borja', 'Mayoral', 'Delantero', 19, 18),
-- Real Valladolid CF (19)
('Karl', 'Hein', 'Portero', 13, 19), ('Luis', 'Pérez', 'Defensa', 2, 19), ('Javi', 'Sánchez', 'Defensa', 5, 19), ('Flavien', 'Boyomo', 'Defensa', 6, 19), ('Lucas', 'Rosa', 'Defensa', 22, 19), ('Stanko', 'Jurić', 'Centrocampista', 20, 19), ('Kike', 'Pérez', 'Centrocampista', 4, 19), ('Selim', 'Amallah', 'Centrocampista', 8, 19), ('Raúl', 'Moro', 'Delantero', 11, 19), ('Amath', 'Ndiaye', 'Delantero', 19, 19), ('Mamadou', 'Sylla', 'Delantero', 7, 19), ('André', 'Ferreira', 'Portero', 1, 19), ('David', 'Torres', 'Defensa', 24, 19), ('Víctor', 'Meseguer', 'Centrocampista', 17, 19), ('Juanmi', 'Latasa', 'Delantero', 9, 19),
-- RCD Espanyol (20)
('Joan', 'García', 'Portero', 1, 20), ('Omar', 'El Hilali', 'Defensa', 23, 20), ('Marash', 'Kumbulla', 'Defensa', 4, 20), ('Leandro', 'Cabrera', 'Defensa', 6, 20), ('Carlos', 'Romero', 'Defensa', 22, 20), ('Alex', 'Král', 'Centrocampista', 20, 20), ('José', 'Gragera', 'Centrocampista', 15, 20), ('Álvaro', 'Aguado', 'Centrocampista', 8, 20), ('Javi', 'Puado', 'Delantero', 7, 20), ('Alejo', 'Véliz', 'Delantero', 9, 20), ('Irvin', 'Cardona', 'Delantero', 17, 20), ('Fernando', 'Pacheco', 'Portero', 13, 20), ('Sergi', 'Gómez', 'Defensa', 3, 20), ('Pol', 'Lozano', 'Centrocampista', 10, 20), ('Pere', 'Milla', 'Delantero', 11, 20);

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
