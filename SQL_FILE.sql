
-- Objective: To analyze rental trends, identify popular films, and assess store performance using the MavenMovies Sakila database.

/*  1. Rental Trends:

1.1) Analyze the monthly rental trends over the available data period.
1.2) Determine the peak rental hours in a day based on rental transactions. */


-- Task 1.1) Analyze the monthly rental trends over the available data period.

SELECT date_format(rental_date, '%Y-%m') AS months,
COUNT(*) AS rental_count FROM rental
GROUP BY months
ORDER BY months;

-- Task 1.2) Determine the peak rental hours in a day based on rental transactions.

SELECT Hour(rental_date) AS rental_hours,
COUNT(*) AS rental_count 
FROM rental
GROUP BY rental_hours
ORDER BY rental_hours; 

/* 2) Film Popularity:	

2.1) Identify the top 10 most rented films.
2.2) Determine which film categories have the highest number of rentals. */


-- Task 2.1) Identify the top 10 most rented films.

SELECT title, COUNT(*) AS rental_count
FROM film INNER JOIN inventory
ON film.film_id= inventory.film_id
INNER JOIN rental
ON inventory.inventory_id= rental.inventory_id
GROUP BY title
ORDER BY rental_count desc
LIMIT 10 ;


-- Task 2.2) Determine which film categories have the highest number of rentals.

SELECT name, COUNT(*) AS rental_count
FROM rental INNER JOIN inventory
ON rental.inventory_id= inventory.inventory_id
INNER JOIN film
ON inventory.film_id= film.film_id
INNER JOIN film_category
ON film.film_id= film_category.film_id
INNER JOIN category
ON film_category.category_id=category.category_id
GROUP BY name
ORDER BY rental_count DESC; 

/* 3. Store Performance:

3.1) Identify which store generates the highest rental revenue.
3.2) Determine the distribution of rentals by staff members to assess performance. */


-- Task 3.1) Identify which store generates the highest rental revenue.

SELECT store.store_id AS store,
SUM(payment.amount) AS total_revenue
FROM payment INNER JOIN rental
ON payment.rental_id=rental.rental_id
INNER JOIN inventory
ON rental.inventory_id=inventory.inventory_id
INNER JOIN store
ON inventory.store_id=store.store_id
GROUP BY store
ORDER BY total_revenue;


-- Task 3.2) Determine the distribution of rentals by staff members to assess performance.

SELECT 
CONCAT(first_name,space(1),last_name) AS staff,
COUNT(*) AS rental_count
FROM staff INNER JOIN rental
ON staff.staff_id= rental.staff_id
GROUP BY staff
ORDER BY rental_count Desc;

