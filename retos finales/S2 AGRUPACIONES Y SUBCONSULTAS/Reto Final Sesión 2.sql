
-- 1. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con A.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName like "a%";

-- 2. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
SELECT employeeNumber, lastName, firstName FROM employees WHERE lastName LIKE "%on";

-- 3. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE "%on%";

-- 4. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE "%on%";

-- 5. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName NOT LIKE "%b";

-- 6. Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20.
SELECT productCode, productName FROM products WHERE productCode LIKE "%_20%";

-- 7. Dentro de la tabla orderdetails, obten el total de cada orden.
SELECT orderNumber, SUM(priceEach * quantityOrdered) as Total FROM orderdetails GROUP BY orderNumber ;

-- 8. Dentro de la tabla orders obten el número de órdenes por año.
SELECT YEAR(orderDate) AS Año, count(orderNumber) as Numero_Ordenes FROM orders group by YEAR(orderDate);

-- 9. Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA.
SELECT lastName, firstName FROM employees WHERE officeCode in (SELECT officeCode FROM offices WHERE country = 'USA');

-- 10. Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
SELECT customerNumber, checkNumber, amount FROM payments ORDER BY amount DESC LIMIT 1;

-- 11. Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
SELECT customerNumber, checkNumber, amount FROM payments WHERE amount > (SELECT avg(amount) from payments) ;

-- 12. Obten el nombre de aquellos clientes que no han hecho ninguna orden.
SELECT customerName FROM customers WHERE customerName NOT IN (SELECT customerNumber FROM orders);

-- 13. Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.
SELECT MAX(quantityOrdered), MIN(quantityOrdered), avg(quantityOrdered) FROM orderdetails;

-- 14. Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
SELECT status, count(orderNumber) as No_Ordenes FROM orders GROUP BY status;