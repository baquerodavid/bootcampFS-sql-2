USE users;

CREATE TABLE usuarios (
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
edad INT
);

INSERT INTO usuarios (nombre, apellido, email, edad, id_rol) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);

SELECT * FROM usuarios;

CREATE TABLE roles (
id_rol INT PRIMARY KEY AUTO_INCREMENT,
nombre_rol VARCHAR(50) NOT NULL
);

INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');

SELECT * FROM roles;

ALTER TABLE usuarios ADD COLUMN id_rol INT;
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);

INSERT INTO usuarios (nombre, apellido, email, edad, id_rol) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28, 1),
('Maria', 'Lopez', 'maria.lopez@example.com', 32, 2),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25, 3),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30, 4),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22, 1),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35, 2),
('Miguel', 'Perez', 'miguel.perez@example.com', 28, 3),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26, 4),
('Javier', 'Diaz', 'javier.diaz@example.com', 31, 1),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27, 2),
('Elena', 'Moreno', 'elena.moreno@example.com', 29, 3),
('Daniel', 'Romero', 'daniel.romero@example.com', 33, 4),
('Paula', 'Torres', 'paula.torres@example.com', 24, 1),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28, 2),
('Carmen', 'Vega', 'carmen.vega@example.com', 29, 3),
('Adrian', 'Molina', 'adrian.molina@example.com', 34, 4),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26, 1),
('Hector', 'Ortega', 'hector.ortega@example.com', 30, 2),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32, 3),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28, 4);

TRUNCATE TABLE usuarios;

SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol AS rol
FROM usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol;

CREATE TABLE categorias (
id_categoria INT PRIMARY KEY AUTO_INCREMENT,
nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

SELECT * FROM categorias;

ALTER TABLE usuarios ADD COLUMN id_categoria INT;
ALTER TABLE usuarios ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria);

SELECT * FROM usuarios;

UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (2, 6, 10, 14, 18);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (3, 7, 11, 15, 19);
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (4, 8, 12, 16, 20);

SELECT c.nombre_categoria, u.id_usuario, u.nombre, u.apellido, u.email, u.edad 
FROM categorias c
JOIN usuarios u ON u.id_categoria = c.id_categoria
ORDER BY c.id_categoria, u.id_usuario;

SELECT c.nombre_categoria AS categoria, 
GROUP_CONCAT(CONCAT(u.nombre, ' ', u.apellido) ORDER BY u.id_usuario SEPARATOR ', ') AS usuarios
FROM categorias c
JOIN usuarios u ON u.id_categoria = c.id_categoria
GROUP BY c.id_categoria, c.nombre_categoria;

CREATE TABLE usuarios_categorias (
id_usuario_categoria INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT,
id_categoria INT,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);

SELECT * FROM usuarios_categorias;


SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.edad, c.nombre_categoria
FROM usuarios u
JOIN usuarios_categorias uc ON u.id_usuario = uc.id_usuario
JOIN categorias c ON uc.id_categoria = c.id_categoria;

SELECT u.id_usuario, CONCAT(u.nombre, ' ', u.apellido) AS usuario,
GROUP_CONCAT(c.nombre_categoria ORDER BY c.id_categoria SEPARATOR ', ') AS categorias
FROM usuarios u
JOIN usuarios_categorias uc ON uc.id_usuario = u.id_usuario
JOIN categorias c ON c.id_categoria = uc.id_categoria
GROUP BY u.id_usuario, usuario;

SELECT c.id_categoria, c.nombre_categoria,
GROUP_CONCAT(CONCAT(u.nombre, ' ', u.apellido) ORDER BY u.id_usuario SEPARATOR ', ') AS usuarios
FROM categorias c
JOIN usuarios_categorias uc ON uc.id_categoria = c.id_categoria
JOIN usuarios u ON u.id_usuario = uc.id_usuario
GROUP BY c.id_categoria, c.nombre_categoria;

INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(2, 1), (3, 2), (4, 3)
