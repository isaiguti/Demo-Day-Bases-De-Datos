use liquor_sales;

-- 1. ¿Que productos generan mayor volumen de ventas?
select i.item_description, sum(s.sale_dollars) as total_venta
		from items i join sales s on i.item_number = s.item_number
        group by (i.item_number)
        order by total_venta desc;
        
-- 2. ¿Cuales son los 5 productos con menor volumen de venta?
select i.item_description, sum(s.sale_dollars) as total_venta
		from items i join sales s on i.item_number = s.item_number
        group by (i.item_number)
        order by total_venta asc
        limit 5;
        
        
-- 3. ¿Cuales son las 10 ciudades donde se consume mayor volumen de alcohol?        
select s.city, sum(sl.volume_sold_liters) as volumen_alcohol_lt
		from store s join sales sl on s.store_number = sl.store_number
        group by (s.city)
        order by volumen_alcohol_lt desc
        limit 30;
        
-- 4. ¿En que ciudad se consume el mayor volumen de ventas?
select s.city, sum(sl.sale_dollars) as total_venta
		from store s join sales sl on s.store_number = sl.store_number
        group by (city)
        order by total_venta desc;
        
-- 5. ¿En que ciudad no conviene tener un punto de venta de acuerdo al monto de venta?
select s.city, sum(sl.sale_dollars) as total_venta
		from store s join sales sl on s.store_number = sl.store_number
        group by (city)
        order by total_venta asc
        limit 10;

-- 6. ¿Cuales son las categoria que mas vende ?
select c.category_name, sum(s.sale_dollars) as venta_total
		from category c join sales s on c.category_number = s.category
        group by c.category_number
        order by venta_total desc
        limit 5;
        
-- 7. ¿Cual es la categoria que mas vende por ciudad?
select st.city, c.category_name, sum(s.sale_dollars) as venta_total
		from category c join sales s on c.category_number = s.category
        join store st on st.store_number = s.store_number
        group by st.city, s.category
        order by venta_total desc
        limit 20;
        
-- 8. ¿En que fecha se incrementa el volumen de ventas?
select YEAR(date) as anio, SUM(sale_dollars) as total_venta 
		from sales
        group by anio;
        
-- 9. ¿Que producto se vende mas por cantidad?
select i.item_description, sum(bottles_sold) as total_productos_vendidos
		from items i join sales s on i.item_number = s.item_number
        group by i.item_number
        order by total_productos_vendidos desc
        limit 10;
        
-- 10. ¿Que producto se vende menos por cantidad?
select i.item_description, sum(bottles_sold) as total_productos_vendidos
		from items i join sales s on i.item_number = s.item_number
        group by i.item_number
        order by total_productos_vendidos asc
        limit 10;
        
--  11.  ¿En que sucursal se muestra mayor volumen de ventas?
select s.store_name, count(sl.invoice_number) as no_ventas
		from store s join sales sl on s.store_number = sl.store_number
        group by s.store_number
        order by no_ventas desc;
        
-- 12. ¿En que mes hay  menor consumo de alcohol?
select monthname(date) as mes, sum(volume_sold_liters) as consumo_alcohol
		from sales
        group by mes
        order by consumo_alcohol desc;
	/*
-- 13. Determina los tres productos que generan mayor volumen de ventas en cada ciudad ****
select s.city, i.item_description, sum(sl.sale_dollars) as total_venta
		from items i join sales sl on i.item_number = sl.item_number
					 join store s on sl.store_number = s.store_number
                     where i.item_number in (select item_number sales  order by state_bottle_retail desc )
					 group by s.city,i.item_number
					 order by s.store_name, total_venta desc
                     limit 50;
                     */
                     
-- 13. Cuantos paquetes se conosumen por tiendas en cada mes
select s.store_name, monthname(sl.date) as mes, sum(sl.bottles_sold) as no_paquetes
		from store s join sales sl on s.store_number = sl.store_number
					 group by s.store_number, mes
                     order by s.store_name, no_paquetes desc
                     limit 50;
                     
-- 14. Cuantos paquetes de los 3 productos mas vendidos se consumen por condado en un mes 
select c.county, monthname(s.date) as mes, i.item_description ,sum(s.bottles_sold) as no_paquetes
		from county c join sales s on c.county_number = s.county_number
				      join items i on i.item_number = s.item_number
                      where i.item_number in ( 
								select number_item FROM
									(select i.item_number as number_item, sum(sale_dollars) as total_venta
										from items i join sales s on i.item_number = s.item_number
										group by (i.item_number)
										order by total_venta desc
                                        limit 3) no_product_sale
                      )
                      group by c.county, mes
                      order by county, i.item_description, no_paquetes desc;

-- 15. Determina la utilidad de cada producto
select i.item_description, (state_bottle_retail-state_bottle_cost) as utilidad
		from items i join sales s on i.item_number = s.item_number
        group by i.item_number;
        
-- 16. Determina los 10 productos que generan mayor volumen ganancias de utilidad y de esos 10 obten la ganancia total de utilidad por ciudad
select st.city, i.item_description, sum(state_bottle_retail-state_bottle_cost) as suma_venta_utilidad
		from items i join sales s on i.item_number = s.item_number
					 join store st on st.store_number = s.store_number
                     where i.item_number in (
								select number_item FROM
									(select i.item_number as number_item, sum(state_bottle_retail-state_bottle_cost) as total_utilidad
										from items i join sales s on i.item_number = s.item_number
										group by (number_item)
										order by total_utilidad desc
                                        limit 10) no_product_sale
                      )
        group by st.city, i.item_number
        order by st.city, suma_venta_utilidad desc;
	
        
-- 17. Obtener el promedio del precio de todos los productos
select avg(state_bottle_retail) as promedio_precio from sales;

-- 18. ¿Cuantos productos se venden por arriba de la media?
select sum(i.pack) as product_tot_arriba_media
		from items i join sales s on i.item_number = s.item_number
        where s.state_bottle_retail > (select avg(state_bottle_retail) as promedio_precio from sales);
        
-- 19. ¿Cuantos productos se venden por abajo de la media?
select sum(i.pack) as product_tot_abajo_media
		from items i join sales s on i.item_number = s.item_number
        where s.state_bottle_retail < (select avg(state_bottle_retail) as promedio_precio from sales);
        
-- 20 Cuantas sucursales hay por ciudad
select distinct city, count(store_number) as no_sucursales
	from store 
    group by city
    order by no_sucursales desc limit 20;

    
        