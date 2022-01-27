-- Seleccionar Tablas
USE tienda;

-- Mostrar tablas
SHOW tables;

-- Mostrar campos
describe articulo;
describe puesto; 
describe venta;

SELECT * FROM empleado;

SELECT nombre,rfc from empleado;

-- Ejemplo 2
SELECT * FROM empleado WHERE apellido_paterno = 'Risom';
SELECT * FROM empleado WHERE id_puesto > 100;

SELECT * FROM empleado WHERE id_puesto >= 100 AND id_puesto <= 200;
SELECT * FROM empleado WHERE id_puesto BETWEEN 100 AND 200;

SELECT * FROM empleado WHERE id_puesto = 100 OR id_puesto = 200;
SELECT * FROM empleado WHERE id_puesto IN (100,200);

-- RETO 2

-- ¿Cuál es el nombre de los empleados con el puesto 4?
SELECT nombre FROM empleado WHERE id_puesto =4;
-- ¿Qué puestos tienen un salario mayor a $10,000?
SELECT * FROM puesto WHERE salario > 10000;
-- ¿Qué articulos tienen un precio mayor a $1,000 y un iva mayor a 100?
SELECT * FROM articulo WHERE precio > 1000 and iva > 100;
-- ¿Qué ventas incluyen los artículos 135 o 963 y fueron hechas por los empleados 835 o 369? 
SELECT * FROM venta WHERE id_articulo in (135, 963) and id_empleado in (835,369);

-- Ejemplo 4 Ordenamientos y limites
SELECT * FROM puesto order by salario DESC;

-- RETO 3
-- Usando la base de datos tienda, escribe una consulta que permita obtener el top 5 de puestos por salarios.
SELECT * FROM puesto ORDER BY salario DESC LIMIT 5;