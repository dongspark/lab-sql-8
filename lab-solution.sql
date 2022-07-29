USE sakila;
-- 1.Write a query to display for each store its store ID, city, and country.
SELECT s.store_id,c.city,co.country FROM sakila.store as s
JOIN sakila.address as a
ON s.address_id = a.address_id
JOIN sakila.city as c
ON a.city_id = c.city_id
JOIN sakila.country as co
ON c.country_id = co.country_id;

-- 2.Write a query to display how much business, in dollars, each store brought in.
SELECT sto.store_id,co.country,sum(p.amount),
  case co.country
      when 'Canada' then sum(p.amount*0.78)
        when 'Australia' then sum(p.amount*0.7)
  end as amount_doller
-- IF(co.country = 'Canada', sum(amount*0.78), sum(amount * 0.7) ,this is just another way trying but failed.
FROM sakila.payment as p
JOIN sakila.staff as sta
ON p.staff_id = sta.staff_id
JOIN sakila.store as sto
ON sta.store_id=sto.store_id
JOIN sakila.address as a
ON sto.address_id = a.address_id
JOIN sakila.city as c
ON a.city_id = c.city_id
JOIN sakila.country as co
ON c.country_id = co.country_id
group by sto.store_id; 

-- 3.Which film categories are longest?
SELECT c.name, avg(f.length)  as avg_length
FROM sakila.film as f
JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
JOIN sakila.category as c
ON fc.category_id = c.category_id
group by c.name
order by avg_length DESC;

-- 4.Display the most frequently rented movies in descending order.
SELECT f.title, count(r.rental_id) as rental_num
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
group by f.title
order by rental_num DESC;

-- 5.List the top five genres in gross revenue in descending order.
SELECT c.name, sum(p.amount) as revenue
FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.inventory as i
ON fc.film_id = i.film_id
JOIN sakila.rental as r
On i.inventory_id = r.inventory_id
JOIN sakila.payment as p
On r.rental_id = p.rental_id
group by c.name
order by revenue DESC
LIMIT 5;

-- 6.Is "Academy Dinosaur" available for rent from Store 1?
SELECT i.store_id,f.title,r.rental_id,r.rental_date,r.return_date 
FROM sakila.rental as r
JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
JOIN sakila.film as f
ON i.film_id = f.film_id
WHERE i.store_id = 1 and f.title = 'Academy Dinosaur';
-- Yes,because all the film gave been returned.

-- 7.Get all pairs of actors that worked together.
SELECT f.title, A.actor_id AS actor1, B.actor_id AS actor2
FROM film_actor AS A, film_actor AS B
JOIN film AS f
ON B.film_id = f.film_id
JOIN actor AS ac
ON B.actor_id = ac.actor_id 
WHERE A.actor_id <> B.actor_id
AND A.film_id = B.film_id 
ORDER BY A.film_id;
-- can only return actor id,I don't know how to return actor name.

-- 8,Get all pairs of customers that have rented the same film more than 3 times.


-- 9.For each film, list actor that has acted in more films.
SELECT a.last_name,a.first_name,count(fa.actor_id) FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film as f
ON fa.film_id = f.film_id
group by a.last_name
HAVING count(fa.actor_id)>3;


