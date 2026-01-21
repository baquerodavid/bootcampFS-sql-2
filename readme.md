# Relación de tablas

Las notaciones 1:1, 1:N y N:M son términos utilizados en el diseño de bases de datos para describir la relación entre tablas. Aquí hay una explicación de cada uno:

* Relación 1:1 (One-to-One):

En una relación 1:1, un registro en una tabla está asociado con un solo registro en otra tabla, y viceversa.
Es similar a decir que cada entidad en la primera tabla tiene una única entidad correspondiente en la segunda tabla, y viceversa.
Un ejemplo podría ser la relación entre una tabla de empleados y una tabla de información confidencial, donde cada empleado tiene una única entrada en la tabla de información confidencial.

* Relación 1:N (One-to-Many):

En una relación 1:N, un registro en una tabla puede estar asociado con varios registros en otra tabla, pero un registro en la segunda tabla está asociado con solo un registro en la primera tabla.
Es común y ampliamente utilizado en muchas bases de datos. Por ejemplo, la relación entre una tabla de clientes y una tabla de pedidos, donde un cliente puede realizar varios pedidos, pero cada pedido pertenece a un único cliente.

* Relación N:M (Many-to-Many):

En una relación N:M, varios registros en una tabla pueden estar asociados con varios registros en otra tabla. No hay restricciones en la cantidad de asociaciones que pueden existir.
Se implementa mediante la introducción de una tercera tabla (tabla de unión o tabla intermedia) que conecta las dos tablas principales. Esta tabla intermedia contiene generalmente claves foráneas que hacen referencia a las tablas principales.
Un ejemplo podría ser la relación entre estudiantes y cursos en una universidad, donde un estudiante puede estar inscrito en varios cursos, y cada curso puede tener varios estudiantes.
Estas relaciones son esenciales para modelar la complejidad de las relaciones del mundo real en una base de datos relacional. La elección entre ellas dependerá de la naturaleza de los datos y las relaciones que estás modelando.

# Objetivo

El objetivo del ejercicio es brindarte práctica en el diseño y manipulación de bases de datos relacionales utilizando SQL. A lo largo de los ejercicios, descubrirás varios conceptos y operaciones comunes en el contexto de bases de datos relacionales.

# Comienza el ejercicio

## Relación tipo 1:1

### PASO 1 - Crea una tabla `usuarios` con:

- id_usuario: tipo número, que sea una clave primaria e incremente su número.
- nombre: tipo texto y no puede dejarse el campo vacío. Máximo 50 caracteres.
- apellido tipo texto y no puede dejarse el campo vacío. Máximo 100 caracteres.
- email: tipo texto y no puede dejarse el campo vacío. Máximo 100 caracteres.
- edad: tipo número.

Añade estos valores a `usuarios`

```SQL
INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
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
```
### PASO 2 - Crea una tabla de `roles`

- id_rol: tipo número, que sea una clave primaria e incremente su número.
- nombre_rol: tipo texto y no puede dejarse el campo vacío. Máximo 50 caracteres.

Añade estos valores a `roles`

```SQL
-- Insertar datos de roles
INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');
``` 
### PASO 3 - Crea la columna `id_rol` u la clave foránea

Añade la columna `id_rol` a usuarios. Rellena cada rol con números asociados a la tabla de `roles` 

Crea la clave foránea (FOREIGN)
```SQL 
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);
```

*** EXPLICACIÓN *** 
La clave foránea es una herramienta clave en las bases de datos relacionales para mantener la integridad referencial entre las tablas. Al establecer una clave foránea, se garantiza que los valores en la columna referenciada (en este caso, id_rol en la tabla usuarios) existan en la tabla referenciada (roles). Esto evita situaciones donde podrías tener usuarios con roles que no existen en la tabla de roles.

Si decides no utilizar una clave foránea y aún así intentas establecer una relación 1:1, estarías dejando de lado las garantías de integridad referencial y podrías enfrentar problemas de consistencia de datos. Por ejemplo, podrías tener usuarios con roles que no existen o roles sin usuarios asociados.

### PASO 4 - JOIN

Haz un `JOIN` que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol de las dos tablas

## Relación tipo 1:N (Uno a varios)

### PASO 1 - Crea una tabla `categorias` con:

- id_categoria: tipo número, que sea una clave primaria e incremente su número.
- nombre_categoría: tipo texto y no puede dejarse el campo vacío. Máximo 100 caracteres.

Añade estos datos a categorías

```SQL

-- Insertar datos de categorías
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
```
### PASO 2 - Añade a la tabla `usuarios` la columna `id_categoria`
La columna debe ser tipo número


### PASO 3 - Añade categorías a varios usuarios
Podría ser algo así:
```SQL
-- Asignar categorías a usuarios específicos
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 5, 9, 13, 17);
```

### PASO 4 - Realiza cuna consulta para ver la unión de usuarios, roles y categorías

Haz un `JOIN` que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria

## Relación tipo N:M (muchos a muchos)

### PASO 1 - Crea una tabla intermedia llamada `usuarios_categorias` con:

- id_usuario_categoria: tipo número, que sea una clave primaria e incremente su número.
- id_usuario: tipo número.
- id_categoría: tipo número.

Añadiremos dentro de la creación de la tabla intermedia dos claves foráneas.
- Una que haga referencia el `id_usaurio` de la tabla intermedia con el `id_usuario` de `usuarios`
- Una que haga referencia el `id_categoría` de la tabla intermedia con el `id_categoria` de `categorías`

Podría ser algo como esto:

```SQL
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
--- Crea tú la otra
```

### PASO 2 - Asocia usuarios a categorías

```SQL
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10),
```

### PASO 3 - Consulta para ver la unión de usuarios, roles, categorías

Haz un `JOIN` que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad,
roles.nombre_rol, categorias.nombre_categoria
