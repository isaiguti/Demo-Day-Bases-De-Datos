use tienda;

-- Ejemplo 1

-- Buscar con like
SELECT * FROM empleado WHERE nombre = "Matty";
SELECT * FROM empleado WHERE nombre LIKE "M%";
SELECT * FROM empleado WHERE nombre LIKE "M%A";
SELECT * FROM empleado WHERE nombre LIKE "M_losa";
SELECT * FROM empleado WHERE nombre LIKE "%Pantalla%";

-- Reto 1: Agrupamientos y subconsultas
-- ¿Qué artículos incluyen la palabra Pasta en su nombre?
-- ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
-- ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT * FROM articulo WHERE nombre LIKE "%pasta%";
SELECT * FROM articulo WHERE nombre LIKE "%Cannelloni%";
SELECT * FROM articulo WHERE nombre LIKE "% - %";


-- Ejemplo 2
SELECT AVG(precio) FROM articulo;
SELECT AVG(precio) FROM articulo WHERE cantidad = 1;
SELECT count(*) FROM articulo;
SELECT max(precio) FROM articulo;
SELECT min(precio) FROM articulo;
SELECT sum(precio) FROM articulo;

-- Reto 2: Funciones de agrupamiento
-- Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
-- ¿Cuál es el promedio de salario de los puestos?
SELECT avg(salario) AS Promedio FROM puesto ;
-- ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
SELECT count(*) AS Cantidad_articulos_pasta FROM articulo WHERE nombre LIKE "%pasta%";
-- ¿Cuál es el salario mínimo y máximo?
SELECT max(salario) AS Salario_Maximo, min(salario) AS Salario_Minimo FROM puesto ;
-- ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
SELECT sum(salario) AS Suma_Salario_Ultimos_5 FROM  (SELECT salario FROM puesto order by id_puesto DESC LIMIT 5) AS subconsulta;

-- Ejemplo 3

SELECT nombre, sum(precio) AS total FROM articulo GROUP BY nombre;
SELECT nombre, count(*) AS cantidad from articulo GROUP BY nombre ORDER BY cantidad DESC;
SELECT nombre, min(salario) AS menor, max(salario) AS mayor FROM puesto GROUP BY nombre;

-- Reto 3 🚀
-- Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
-- ¿Cuántos registros hay por cada uno de los puestos?
SELECT nombre, count(*) AS Cantidad FROM puesto group by nombre;
-- ¿Cuánto dinero se paga en total por puesto?
SELECT nombre, SUM(salario) AS Cantidad FROM puesto group by nombre;
-- ¿Cuál es el número total de ventas por vendedor?
SELECT id_empleado, count(*) AS Cantidad FROM venta group by id_empleado;
SELECT e.nombre, count(v.id_venta) AS Cantidad FROM venta v inner join empleado e on e.id_empleado = v.id_empleado  group by e.nombre;
-- ¿Cuál es el número total de ventas por artículo?
SELECT id_articulo, count(*) AS Cantidad FROM venta group by id_articulo;
SELECT a.nombre, count(v.id_venta) AS Cantidad FROM venta v inner join articulo a on a.id_articulo = v.id_articulo  group by a.nombre;

-- Ejemplo 4

SELECT salario FROM puesto WHERE id_puesto = 1;
SELECT nombre, apellido_paterno FROM empleado;
SELECT nombre, apellido_paterno, (SELECT salario FROM puesto WHERE id_puesto = e.id_puesto) as Salario FROM empleado e;

-- RETO 4
-- Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
-- ¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
SELECT nombre from empleado where id_puesto in (SELECT id_puesto from puesto WHERE salario < 10000);
-- ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
SELECT id_empleado,clave, count(*) AS Total_Venta FROM venta GROUP BY clave,id_empleado order by id_empleado;
SELECT id_empleado, min(Total_Venta), max(Total_Venta) FROM 
	(SELECT id_empleado,clave, count(*) AS Total_Venta 
		FROM venta 
        GROUP BY clave,id_empleado) AS SQ group by id_empleado;

-- ¿Cuál es el nombre del puesto de cada empleado?
SELECT nombre, apellido_paterno, (SELECT nombre FROM puesto WHERE id_puesto = e.id_puesto) as Puesto  from empleado e;

