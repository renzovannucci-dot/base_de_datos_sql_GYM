CREATE DATABASE IF NOT EXISTS APPGYM;
USE APPGYM;

CREATE TABLE clase (
id_clase INT PRIMARY KEY auto_increment,
nombre_clase VARCHAR(50)
);

-- Inserciones en tabla clase (8 clases)
INSERT INTO clase (nombre_clase) VALUES
('Rugby Kids'),
('Yoga Adultos'),
('CrossFit Juvenil'),
('Pilates'),
('Zumba'),
('Spinning'),
('Boxeo'),
('Natación');

CREATE TABLE cliente (
id_cliente INT PRIMARY KEY auto_increment,
nombre_cliente VARCHAR(50),
apellido_cliente VARCHAR(50),
edad INT, 
celular_cliente INT,
FOREIGN KEY(id_clase) REFERENCES clase(id_clase)
);
-- Inserciones en tabla cliente (20 clientes)
INSERT INTO cliente (nombre_cliente, apellido_cliente, edad, celular_cliente, id_clase) VALUES
('Renzo', 'Vannucci', 28, 111111111, 1),
('Lucía', 'Gómez', 25, 222222222, 2),
('Martín', 'Pérez', 30, 333333333, 3),
('Sofía', 'Rodríguez', 22, 444444444, 4),
('Juan', 'García', 27, 555555555, 5),
('Valentina', 'Fernández', 29, 666666666, 6),
('Diego', 'López', 31, 777777777, 7),
('Camila', 'Martínez', 24, 888888888, 8),
('Lucas', 'Sánchez', 26, 999999999, 1),
('Micaela', 'Torres', 28, 123123123, 2),
('Tomás', 'Ramírez', 23, 321321321, 3),
('Martina', 'Jiménez', 27, 456456456, 4),
('Facundo', 'Ruiz', 25, 654654654, 5),
('Agustina', 'Romero', 26, 789789789, 6),
('Nicolás', 'Vega', 30, 987987987, 7),
('Paula', 'Cruz', 29, 147147147, 8),
('Federico', 'Blanco', 28, 258258258, 1),
('Isabella', 'Rojas', 24, 369369369, 2),
('Santiago', 'Molina', 32, 159159159, 3),
('Antonella', 'Herrera', 27, 753753753, 4);


CREATE TABLE clase_cliente (
id_cliente INT ,
id_clase INT,
PRIMARY KEY(id_cliente, id_clase) ,
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
FOREIGN KEY(id_clase) REFERENCES clase(id_clase)
);

-- Inserciones en tabla clase_cliente (relación N a N)
INSERT INTO clase_cliente (id_cliente, id_clase) VALUES
(1,1),(1,2),(2,2),(3,1),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),
(9,1),(10,2),(11,3),(12,4),(13,5),(14,6),(15,7),(16,8),(17,1),(18,2),
(19,3),(20,4);

CREATE TABLE horario_clase (
id_hora INT PRIMARY KEY auto_increment,
hora TIME,
id_clase INT,
FOREIGN KEY(id_clase) REFERENCES clase(id_clase)
);
-- Inserciones en tabla horario_clase
INSERT INTO horario_clase (hora, id_clase) VALUES
('08:00:00',1),
('09:30:00',2),
('11:00:00',3),
('12:30:00',4),
('14:00:00',5),
('15:30:00',6),
('17:00:00',7),
('18:30:00',8);

CREATE TABLE profesor (
id_profesor INT PRIMARY KEY auto_increment,
nombre_profesor VARCHAR(50),
apellido_profesor VARCHAR(50),
edad_profesor INT, 
celular_profesor INT,
id_hora INT,
FOREIGN KEY(id_hora) REFERENCES horario_clase(id_hora)
);
-- Inserciones en tabla profesor
INSERT INTO profesor (nombre_profesor, apellido_profesor, edad_profesor, celular_profesor, id_hora) VALUES
('Carlos','Ramírez',35,111111111,1),
('Ana','López',29,222222222,2),
('Javier','Torres',40,333333333,3),
('Laura','Gómez',32,444444444,4),
('Martín','Pérez',38,555555555,5),
('Sofía','Rodríguez',28,666666666,6),
('Diego','López',36,777777777,7),
('Valentina','Fernández',30,888888888,8);

CREATE TABLE pago (
id_pago INT PRIMARY KEY auto_increment,
fecha DATETIME,
metodo VARCHAR(50),
id_cliente INT,
FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
);
-- Inserciones en tabla pago
INSERT INTO pago (fecha, metodo, id_cliente) VALUES
('2025-08-20 09:00:00','Efectivo',1),
('2025-08-21 10:30:00','Tarjeta',2),
('2025-08-22 11:00:00','Transferencia',3),
('2025-08-23 12:00:00','Efectivo',4),
('2025-08-24 13:00:00','Tarjeta',5),
('2025-08-25 14:30:00','Transferencia',6),
('2025-08-26 15:00:00','Efectivo',7),
('2025-08-27 16:00:00','Tarjeta',8),
('2025-08-28 17:00:00','Transferencia',9),
('2025-08-29 18:30:00','Efectivo',10),
('2025-08-30 09:00:00','Tarjeta',11),
('2025-08-31 10:00:00','Transferencia',12),
('2025-09-01 11:00:00','Efectivo',13),
('2025-09-02 12:30:00','Tarjeta',14),
('2025-09-03 14:00:00','Transferencia',15),
('2025-09-04 15:00:00','Efectivo',16),
('2025-09-05 16:30:00','Tarjeta',17),
('2025-09-06 17:00:00','Transferencia',18),
('2025-09-07 18:00:00','Efectivo',19),
('2025-09-08 19:00:00','Tarjeta',20);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY auto_increment,
    id_cliente INT,
    id_hora INT,
    estado ENUM('confirmado','cancelado') DEFAULT 'confirmado',
    fecha_reserva DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_hora) REFERENCES horario_clase(id_hora)
);

INSERT INTO reserva (id_cliente, id_hora, estado, fecha_reserva) VALUES
(1, 1, 'confirmado', '2025-08-21 09:00:00'),
(2, 2, 'confirmado', '2025-08-21 10:00:00'),
(3, 3, 'cancelado', '2025-08-21 11:30:00'),
(1, 5, 'confirmado', '2025-08-22 08:00:00'),
(4, 2, 'confirmado', '2025-08-22 09:30:00'),
(5, 3, 'confirmado', '2025-08-22 11:00:00'),
(6, 6, 'confirmado', '2025-08-23 14:30:00'),
(7, 7, 'cancelado', '2025-08-23 15:00:00'),
(8, 8, 'confirmado', '2025-08-23 18:30:00'),
(9, 1, 'confirmado', '2025-08-24 08:00:00');

SELECT 
nombre_cliente AS nombre_cliente,
apellido_cliente AS apellido_cliente,
nombre_clase AS nombre_clase,
hora AS horario_clase
FROM cliente cl
INNER JOIN clase_cliente cc
ON cl.id_cliente = cc.id_cliente
INNER JOIN clase c
ON   cc.id_clase = c.id_clase
INNER JOIN horario_clase hc
ON cc.id_clase = hc.id_clase;

select * from reserva;
SELECT r.id_reserva, c.nombre_cliente, hc.hora, cl.nombre_clase
FROM reserva r
JOIN cliente c ON r.id_cliente = c.id_cliente
JOIN horario_clase hc ON r.id_hora = hc.id_hora
JOIN clase cl ON hc.id_clase = cl.id_clase
WHERE r.estado = 'confirmado' AND c.id_cliente = 1;