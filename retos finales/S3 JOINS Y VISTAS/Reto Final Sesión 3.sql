USE classicmodels;
-- 1. Obtén la cantidad de productos de cada orden.
SELECT o.orderNumber, sum(quantityOrdered) as Cantidad_Productos FROM orders o 
		JOIN orderdetails od on o.orderNumber = od.orderNumber
        JOIN products p on od.productCode = p.productCode
        GROUP BY o.orderNumber;

-- 2. Obten el número de orden, estado y costo total de cada orden.
SELECT  o.orderNumber, o.status, SUM(quantityOrdered*priceEach) as Costo_TOTAL FROM orders o 
						JOIN orderdetails od on o.orderNumber = od.orderNumber
                        GROUP BY o.orderNumber;

-- 3. Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
SELECT o.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
	FROM orders o
    JOIN orderdetails od on o.orderNumber = od.orderNumber
    JOIN products p on od.productCode = p.productCode;

-- 4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT o.orderNumber, p.productName, p.MSRP, od.priceEach FROM orders o
				JOIN orderdetails od on o.orderNumber = od.orderNumber
				JOIN products p on od.productCode = p.productCode;

-- Para estas consultas usa LEFT JOIN
-- 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
-- Nos funciona para obtener todas las ordenes que se tengan y los clientes que estan dentro de esas ordenes, si llegara a
-- existir una orden que no este ligada con un cliente y utilizamos un JOIN no apareceria en el resultado.
SELECT c.customerNumber, concat(c.contactFirstName,' ',c.contactLastName) as Nombre, o.orderNumber, o.status
		FROM orders o 
        LEFT JOIN customers c on o.customerNumber = c.customerNumber;
        
-- 6. Obtén los clientes que no tienen una orden asociada.
SELECT c.customerNumber, concat(c.contactFirstName,' ',c.contactLastName) as Nombre, o.orderNumber
		FROM customers c
        LEFT JOIN orders o on c.customerNumber = o.customerNumber
        WHERE o.orderNumber is null;
        
-- 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT concat(e.lastName, ' ', e.firstName) as Employee_Name, c.customerName, p.checkNumber, p.amount 
		FROM customers c 
        LEFT JOIN employees e on c.salesRepEmployeeNumber = e.employeeNumber
        LEFT JOIN payments p on c.customerNumber = p.customerNumber;
        
-- Para estas consultas usa RIGHT JOIN
-- 8. Repite los ejercicios 5 a 7 usando RIGHT JOIN. ¿Representan lo mismo? Explica las diferencias en un comentario. Para poner comentarios usa --.
-- 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer RIGHT JOIN en lugar de JOIN?
-- Nos funciona para obtener todas los clientes que se tengan y asociado o no una orden
SELECT c.customerNumber, concat(c.contactFirstName,' ',c.contactLastName) as Nombre, o.orderNumber, o.status
		FROM orders o 
        RIGHT JOIN customers c on o.customerNumber = c.customerNumber;
        
-- 6. Obtén los clientes que no tienen una orden asociada.
-- Si utilizamos un RIGHT vamos a obtener todas las ordenes que tengamos y los clientes que esten asociadas a ellas
-- por lo cual este resultado estara vacio ya que no dara nunca nulo por que estamos obteniendo todos los numeros de orderes.
SELECT c.customerNumber, concat(c.contactFirstName,' ',c.contactLastName) as Nombre, o.orderNumber
		FROM customers c
        RIGHT JOIN orders o on c.customerNumber = o.customerNumber
        WHERE o.orderNumber is null;
        
-- 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
-- Vamos a obtener todos los empleados con los clientes que esten asociados a ellos y de la misma forma todos los pagos que
-- esten asociados a los clientes y empleados
SELECT concat(e.lastName, ' ', e.firstName) as Employee_Name, c.customerName, p.checkNumber, p.amount 
		FROM customers c 
        RIGHT JOIN employees e on c.salesRepEmployeeNumber = e.employeeNumber
        RIGHT JOIN payments p on c.customerNumber = p.customerNumber;
        
-- Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
-- Obten el número de orden, estado y costo total de cada orden.
CREATE VIEW ordenes_costo_745 AS 
	SELECT o.orderNumber, o.status, SUM(quantityOrdered*priceEach) as Costo_TOTAL FROM orders o 
						JOIN orderdetails od on o.orderNumber = od.orderNumber
                        GROUP BY o.orderNumber;
                        
SELECT status, SUM(Costo_Total) FROM ordenes_costo_745 GROUP BY status;

-- Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
CREATE VIEW orden_producto_745 AS
	SELECT o.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
		FROM orders o
		JOIN orderdetails od on o.orderNumber = od.orderNumber
		JOIN products p on od.productCode = p.productCode;
        
SELECT productName, SUM(quantityOrdered) FROM orden_producto_745 GROUP BY productName;

-- Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
CREATE VIEW producto_precio_745 AS
	SELECT o.orderNumber, p.productName, p.MSRP, od.priceEach FROM orders o
				JOIN orderdetails od on o.orderNumber = od.orderNumber
				JOIN products p on od.productCode = p.productCode;

SELECT orderNumber, productName FROM producto_precio_745 WHERE priceEach > MSRP