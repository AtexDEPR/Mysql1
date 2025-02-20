-- Creación de la base de datos

CREATE DATABASE pizza_fiesta;

USE pizza_fiesta;


-- Tabla de Clientes

CREATE TABLE clientes (

    id_cliente INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    telefono VARCHAR(15) NOT NULL,

    direccion TEXT NOT NULL,

    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP

);


-- Tabla de Categorías de Productos

CREATE TABLE categorias_productos (

    id_categoria INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(50) NOT NULL

);


-- Tabla de Tamaños

CREATE TABLE tamanos (

    id_tamano INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(20) NOT NULL

);


-- Tabla de Productos

CREATE TABLE productos (

    id_producto INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    descripcion TEXT,

    id_categoria INT,

    activo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_categoria) REFERENCES categorias_productos(id_categoria)

);


-- Tabla de Precios por Tamaño

CREATE TABLE precios_productos (

    id_producto INT,

    id_tamano INT,

    precio DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_producto, id_tamano),

    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),

    FOREIGN KEY (id_tamano) REFERENCES tamanos(id_tamano)

);


-- Tabla de Ingredientes

CREATE TABLE ingredientes (

    id_ingrediente INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(50) NOT NULL,

    precio_extra DECIMAL(10,2) NOT NULL,

    disponible BOOLEAN DEFAULT TRUE

);


-- Tabla de Ingredientes base por producto

CREATE TABLE ingredientes_producto (

    id_producto INT,

    id_ingrediente INT,

    PRIMARY KEY (id_producto, id_ingrediente),

    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),

    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)

);


-- Tabla de Pedidos

CREATE TABLE pedidos (

    id_pedido INT PRIMARY KEY AUTO_INCREMENT,

    id_cliente INT,

    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,

    hora_recogida DATETIME NOT NULL,

    estado VARCHAR(20) DEFAULT 'PENDIENTE',

    total DECIMAL(10,2),

    pagado BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)

);


-- Tabla de Detalles del Pedido

CREATE TABLE detalles_pedido (

    id_detalle INT PRIMARY KEY AUTO_INCREMENT,

    id_pedido INT,

    id_producto INT,

    id_tamano INT,

    cantidad INT NOT NULL,

    precio_unitario DECIMAL(10,2) NOT NULL,

    subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),

    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),

    FOREIGN KEY (id_tamano) REFERENCES tamanos(id_tamano)

);


-- Tabla de Ingredientes Extra en Pedidos

CREATE TABLE ingredientes_extra_pedido (

    id_detalle INT,

    id_ingrediente INT,

    precio_extra DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_detalle, id_ingrediente),

    FOREIGN KEY (id_detalle) REFERENCES detalles_pedido(id_detalle),

    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)

);


-- Tabla de Combos

CREATE TABLE combos (

    id_combo INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(100) NOT NULL,

    descripcion TEXT,

    precio DECIMAL(10,2) NOT NULL,

    activo BOOLEAN DEFAULT TRUE

);


-- Tabla de Productos en Combos

CREATE TABLE productos_combo (

    id_combo INT,

    id_producto INT,

    id_tamano INT,

    cantidad INT NOT NULL,

    PRIMARY KEY (id_combo, id_producto, id_tamano),

    FOREIGN KEY (id_combo) REFERENCES combos(id_combo),

    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),

    FOREIGN KEY (id_tamano) REFERENCES tamanos(id_tamano)

);


-- Insertar datos iniciales

-- Categorías

INSERT INTO categorias_productos (nombre) VALUES 

('Pizzas'),

('Bebidas');


-- Tamaños

INSERT INTO tamanos (nombre) VALUES 

('Personal'),

('Mediana'),

('Familiar');


-- Productos base

INSERT INTO productos (nombre, descripcion, id_categoria) VALUES

('Pizza Margherita', 'Pizza clásica italiana con salsa de tomate, mozzarella y albahaca', 1),

('Pizza Pepperoni', 'Pizza con pepperoni importado', 1),

('Pizza Hawaiana', 'Pizza con jamón y piña', 1),

('Pizza Pollo BBQ', 'Pizza con pollo y salsa BBQ', 1),

('Coca-Cola', 'Bebida gaseosa', 2),

('Sprite', 'Bebida gaseosa lima limón', 2),

('Agua', 'Agua mineral', 2);


-- Precios de productos

INSERT INTO precios_productos (id_producto, id_tamano, precio) VALUES

-- Pizza Margherita

(1, 1, 18000),

(1, 2, 35000),

(1, 3, 45000),


-- Pizza Pepperoni

(2, 1, 22000),

(2, 2, 39000),

(2, 3, 49000),


-- Pizza Hawaiana

(3, 1, 20000),

(3, 2, 37000),

(3, 3, 47000),


-- Pizza Pollo BBQ

(4, 1, 22000),

(4, 2, 39000),

(4, 3, 49000),


-- Bebidas

(5, 1, 5000),

(6, 1, 5000),

(7, 1, 3000);


-- Ingredientes

INSERT INTO ingredientes (nombre, precio_extra) VALUES

('Queso Extra', 6000),

('Pepperoni Extra', 7000),

('Champiñones', 4000),

('Jalapeños', 3000),

('Aceitunas', 4000),

('Tomate', 2000),

('Cebolla', 2000),

('Pimentón', 2000),

('Pollo Extra', 8000),

('Jamón Extra', 6000);


-- Combos

INSERT INTO combos (nombre, descripcion, precio, activo) VALUES

('Combo Familiar', 'Pizza familiar (3 ingredientes) + 2 gaseosas', 58000, TRUE),

('Combo Pareja', 'Pizza mediana (2 ingredientes) + 2 gaseosas', 45000, TRUE),

('Combo Personal', 'Pizza personal (1 ingrediente) + 1 gaseosa', 25000, TRUE);


-- Clientes de ejemplo

INSERT INTO clientes (nombre, telefono, direccion) VALUES

('Ana María González', '311-555-0101', 'Calle 123 #45-67, Bogotá'),

('Carlos Rodríguez', '320-555-0202', 'Carrera 78 #90-12, Medellín'),

('Laura Martínez', '315-555-0303', 'Avenida 34 #56-78, Cali');


-- Pedidos de ejemplo

INSERT INTO pedidos (id_cliente, hora_recogida, estado, total, pagado) VALUES

(1, '2025-02-19 14:30:00', 'COMPLETADO', 58000, TRUE),

(2, '2025-02-19 15:00:00', 'EN_PREPARACION', 45000, TRUE),

(3, '2025-02-19 15:30:00', 'PENDIENTE', 25000, FALSE);


-- Detalles de pedidos

INSERT INTO detalles_pedido (id_pedido, id_producto, id_tamano, cantidad, precio_unitario, subtotal) VALUES

(1, 1, 3, 1, 45000, 45000),

(1, 5, 1, 2, 5000, 10000),

(2, 2, 2, 1, 39000, 39000),

(2, 6, 1, 2, 5000, 10000),

(3, 3, 1, 1, 20000, 20000),

(3, 5, 1, 1, 5000, 5000);


-- Ingredientes extra en pedidos

INSERT INTO ingredientes_extra_pedido (id_detalle, id_ingrediente, precio_extra) VALUES

(1, 1, 6000),

(2, 3, 4000);


-- Productos en combos

INSERT INTO productos_combo (id_combo, id_producto, id_tamano, cantidad) VALUES

(1, 1, 3, 1), -- Pizza familiar para combo familiar

(1, 5, 1, 2), -- 2 Coca-Colas para combo familiar

(2, 1, 2, 1), -- Pizza mediana para combo pareja

(2, 5, 1, 2), -- 2 Coca-Colas para combo pareja

(3, 1, 1, 1), -- Pizza personal para combo personal

(3, 5, 1, 1); -- 1 Coca-Cola para combo personal


-- Ingredientes base por producto

INSERT INTO ingredientes_producto (id_producto, id_ingrediente) VALUES

(1, 1), -- Queso en Margherita

(2, 1), -- Queso en Pepperoni

(2, 2), -- Pepperoni en Pepperoni

(3, 1), -- Queso en Hawaiana

(3, 10), -- Jamón en Hawaiana

(4, 1), -- Queso en Pollo BBQ

(4, 9); -- Pollo en Pollo BBQ


-- Soluciones a las consultas solicitadas


-- 1. Registrar un nuevo cliente

INSERT INTO clientes (nombre, telefono, direccion)

 VALUES ('Juan Pérez', '555-1234', 'Calle Principal 123');


-- 2. Agregar una nueva pizza

INSERT INTO productos (nombre, descripcion, id_categoria)

 VALUES ('Pizza Hawaiana', 'Pizza con jamón y piña', 1);


-- 3. Registrar una bebida

INSERT INTO productos (nombre, descripcion, id_categoria)

 VALUES ('Fanta', 'Refresco de naranja', 2);


-- 4. Agregar un ingrediente

INSERT INTO ingredientes (nombre, precio_extra)

 VALUES ('Aceitunas', 12.00);


-- 5. Crear un pedido

INSERT INTO pedidos (id_cliente, hora_recogida)

 VALUES (1, '2025-02-19 15:00:00');


-- 6. Añadir productos a un pedido

INSERT INTO detalles_pedido (id_pedido, id_producto, id_tamano, cantidad, precio_unitario, subtotal)

 VALUES (1, 1, 2, 1, 120.00, 120.00);


-- 7. Añadir ingredientes extra

INSERT INTO ingredientes_extra_pedido (id_detalle, id_ingrediente, precio_extra)

 VALUES (1, 2, 20.00);


-- 8. Consultar detalle de pedido



-- 9. Actualizar precio de pizza

UPDATE precios_productos

 SET precio = 125.00

 WHERE id_producto = 1 AND id_tamano = 2;


-- 10. Actualizar dirección de cliente

UPDATE clientes

 SET direccion = 'Nueva Dirección 456'

 WHERE id_cliente = 1;


-- 11. Eliminar bebida

UPDATE productos

 SET activo = FALSE

 WHERE id_producto = 4;


-- 12. Eliminar ingrediente

UPDATE ingredientes

 SET disponible = FALSE

 WHERE id_ingrediente = 4;


-- 13. Consultar pedidos de cliente

SELECT id_pedido, fecha_pedido, hora_recogida, estado, total

 FROM pedidos

 WHERE id_cliente = 1;


-- 14. Listar productos disponibles



-- 15. Listar ingredientes disponibles

SELECT nombre, precio_extra

 FROM ingredientes

 WHERE disponible = TRUE;


-- 16. Calcular costo total de pedido



-- 17. Clientes con más de 5 pedidos


-- 18. Pedidos después de hora específica

SELECT * FROM pedidos

 WHERE hora_recogida > '2025-02-19 15:00:00';


-- 19. Listar combos disponibles



-- 20. Pizzas con precio mayor a $100

SELECT p.nombre, t.nombre as tamano, pp.precio

FROM productos p

JOIN precios_productos pp ON p.id_producto = pp.id_producto

JOIN tamanos t ON pp.id_tamano = t.id_tamano

WHERE p.id_categoria = 1 AND pp.precio > 100;


