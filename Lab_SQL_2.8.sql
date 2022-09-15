-- LAB 2.8

USE sakila; 

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, ci.city, co.country
FROM sakila.store s 
JOIN sakila.address a USING(address_id)
JOIN sakila.city ci USING(city_id)
JOIN sakila.country co USING(country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, SUM(p.amount) as 'revenue (USD)'
FROM sakila.payment p
JOIN sakila.staff s USING(staff_id)
JOIN sakila.rental r USING(rental_id)
GROUP BY s.store_id;

-- 3. Which film categories are longest?

SELECT c.name, AVG(f.length) as 'avg_runtime'
FROM sakila.film f 
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

-- Sports are on average longer in length than the other categories

-- 4. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) as 'rental_frequency'
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING (inventory_id)
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC; 

-- 5. List the top five genres in gross revenue in descending order.

SELECT c.name AS 'category', SUM(p.amount) AS 'revenue'
FROM sakila.category c
JOIN sakila.film_category fc USING (category_id)
JOIN sakila.inventory i USING (film_id)
JOIN sakila.rental r USING (inventory_id)
JOIN sakila.payment p USING(rental_id)
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;   

-- Top five grossing genres are Sports, Sci-fi, animation, drama and comedy

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title, s.store_id, COUNT(i.inventory_id) as 'inventory'
FROM sakila.inventory i
JOIN sakila.store s using (store_id) 
JOIN sakila.film f using (film_id)
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;

-- Yes. Four copies are available at store #1. (Would need to confirm how many are rented out currently?)

-- 7. Get all pairs of actors that worked together.

SELECT a.actor_id as 'Actor', a.first_name, a.last_name, fa1.film_id
FROM sakila.film_actor fa1 
JOIN sakila.film_actor fa2 ON (fa1.actor_id <> fa2.actor_id) AND (fa1.film_id = fa2.film_id)
JOIN sakila.actor a ON fa1.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name, fa1.film_id
ORDER BY fa1.film_id;

-- This doesn't show exact result. Would appreciate feedback here.

-- 8. BONUS: Get all pairs of customers that have rented the same film more than 3 times. (We can use JOINs but easier with sub-queries)



-- 9. BONUS: For each film, list actor that has acted in more films. (sub-queries only)



