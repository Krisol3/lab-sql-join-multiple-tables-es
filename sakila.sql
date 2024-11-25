#SQL Joins en múltiples tablas
#En este laboratorio, utilizarás la base de datos Sakila de alquileres de películas.
USE sakila;

#Escribe una consulta para mostrar para cada tienda su ID de tienda, ciudad y país.
SELECT s.store_id, city, country
FROM store AS s
JOIN address AS a
	ON s.address_id = a.address_id
		JOIN city AS ci
			ON ci.city_id = a.city_id
            JOIN country AS co
				ON ci.country_id = co.country_id;
            
#Escribe una consulta para mostrar cuánto negocio, en dólares, trajo cada tienda.
SELECT SUM(p.amount) AS sales_$, s.store_id AS store
FROM payment AS p
JOIN rental AS r
	ON p.rental_id = r.rental_id
	JOIN inventory AS i
		ON i.inventory_id = r.inventory_id
        JOIN store AS s
			ON i.store_id = s.store_id
GROUP BY 2;

#¿Cuál es el tiempo de ejecución promedio de las películas por categoría?
SELECT c.name, AVG(f.length) AS film_duration_avg
FROM category AS c
	JOIN film_category AS fc
		ON c.category_id = fc.category_id
		JOIN film AS f
			ON fc.film_id = f.film_id
GROUP BY 1
ORDER BY 2 DESC;

#¿Qué categorías de películas son las más largas?
SELECT c.name, MAX(f.length) AS film_duration
FROM category AS c
	JOIN film_category AS fc
		ON c.category_id = fc.category_id
		JOIN film AS f
			ON fc.film_id = f.film_id
GROUP BY 1
ORDER BY 2 DESC;
    
#Muestra las películas más alquiladas en orden descendente.
SELECT title, MAX(rental_duration) AS times_rent
FROM film
GROUP BY 1 
ORDER BY 2 DESC;

#Enumera los cinco principales géneros en ingresos brutos en orden descendente.
SELECT c.name, SUM(p.amount) AS ingresos_brutos
FROM category AS c
	JOIN film_category AS fc
    ON c.category_id = fc.category_id
		JOIN inventory AS i
        ON i.film_id = fc.film_id 
			JOIN rental AS r
				ON r.inventory_id = i.inventory_id
					JOIN payment AS p 
						ON r.rental_id = p.rental_id
GROUP BY c.name		
ORDER BY 2 DESC
LIMIT 5;

#¿Está "Academy Dinosaur" disponible para alquilar en la Tienda 1?
SELECT ft.title, store_id, return_date
FROM film_text AS ft
JOIN inventory AS i
	ON ft.film_id = i.film_id
	JOIN rental AS r
		ON r.inventory_id = i.inventory_id
WHERE ft.title = 'Academy Dinosaur' AND store_id = '1'