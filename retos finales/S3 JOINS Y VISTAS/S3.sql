SHOW KEYS FROM venta;

SELECT *
FROM empleado AS e
JOIN puesto AS p
  ON e.id_puesto = p.id_puesto;

SELECT *
FROM puesto AS p
LEFT JOIN empleado e
ON p.id_puesto = e.id_puesto;

SELECT *
FROM empleado AS e
RIGHT JOIN puesto AS p
ON e.id_puesto = p.id_puesto;

-- Reto 1
-- ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT v.id_venta,e.nombre FROM empleado e
			JOIN venta v ON  e.id_empleado = v.id_empleado;
-- ¿Cuál es el nombre de los artículos que se han vendido?
SELECT v.id_venta, a.nombre FROM articulo a
			JOIN venta v ON  a.id_articulo = v.id_articulo;
-- ¿Cuál es el total de cada venta?
SELECT v.id_venta, (a.precio + a.iva) as Total FROM articulo a
			JOIN venta v ON  a.id_articulo = v.id_articulo
            GROUP BY v.id_venta;
            
-- Ejemplo 2
SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo;
  
CREATE VIEW tickets_745 AS
(SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo);
  
SELECT *
FROM tickets_745;

SELECT clave, round(sum(precio),2) total
FROM tickets_745
GROUP BY clave;	

-- Reto 2
-- Obtener el puesto de un empleado.
CREATE VIEW puesto_empleado_745 AS
	SELECT e.nombre as Empleado, p.nombre as Puesto FROM empleado e
						JOIN puesto p on e.id_puesto = p.id_puesto;
                        
-- Saber qué artículos ha vendido cada empleado.
CREATE VIEW articulos_empleado_745 AS
	SELECT e.nombre as Empleado, a.nombre as Articulos FROM empleado e
						JOIN venta v on e.id_empleado = v.id_empleado
						JOIN articulo a on a.id_articulo = v.id_articulo;

-- Saber qué puesto ha tenido más ventas.
CREATE VIEW puesto_ventas_745 AS 
	SELECT p.nombre as Puesto, count(v.id_venta) as Total FROM puesto p
						JOIN empleado e on p.id_puesto = e.id_puesto
                        JOIN venta v on e.id_empleado = v.id_empleado
                        GROUP BY p.nombre
                        ORDER BY Total DESC;