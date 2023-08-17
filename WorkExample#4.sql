SELECT * FROM payment;
SELECT COUNT(*) FROM payment;
SELECT DISTINCT amount FROM payment;
SELECT COUNT(DISTINCT amount) FROM payment;
SELECT * FROM payment ORDER BY payment_date DESC LIMIT 10;
SELECT customer_id FROM payment ORDER BY payment_date ASC LIMIT 10; 
SELECT * FROM payment WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';
SELECT COUNT(*) FROM payment WHERE amount NOT IN (0.99, 1.98, 1.99);
SELECT COUNT(amount) FROM payment WHERE amount > 5;
SELECT customer_id,SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC;
SELECT DATE(payment_date), SUM(amount) FROM payment GROUP BY DATE(payment_date) ORDER BY SUM(amount) DESC;
SELECT staff_id, COUNT(amount) FROM payment GROUP BY staff_id;
SELECT rating, ROUND(AVG(replacement_cost), 2) FROM film GROUP BY rating;
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5;
SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id HAVING SUM(amount) > 200;
SELECT store_id, COUNT(*) FROM customer GROUP BY store_id HAVING COUNT(*) > 300;
SELECT customer_id, COUNT(*) FROM payment GROUP BY customer_id HAVING COUNT(*) >= 40;
SELECT customer_id, SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount) >= 100;
SELECT customer_id, SUM(amount) AS total_spent  FROM payment GROUP BY customer_id HAVING SUM(amount) > 100;
SELECT customer_id, amount AS top_30 FROM payment 
	WHERE amount > 10 and customer_id % 2 = 0 
	ORDER BY customer_id 
	LIMIT 20;
SELECT payment_id, payment.customer_id, first_name FROM payment 
	INNER JOIN customer ON payment.customer_id = customer.customer_id;

SELECT * FROM customer;
SELECT first_name, last_name, email FROM customer;
SELECT * FROM customer WHERE first_name = 'Jared';
SELECT COUNT(*) FROM customer WHERE first_name='Jared';
SELECT email FROM customer WHERE first_name='Nancy' AND last_name='Thomas';
SELECT store_id, first_name, last_name FROM customer ORDER BY store_id DESC, first_name ASC;
SELECT * FROM customer WHERE first_name IN ('John', 'Jake', 'Julie');
SELECT * FROM customer WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'
SELECT * FROM customer WHERE first_name ILIKE 'a%' AND last_name NOT LIKE 'B%' ORDER BY last_name;
SELECT customer_id, first_name, last_name FROM customer 
	WHERE first_name LIKE 'E%' AND address_id < 500 
	ORDER BY customer_id DESC 
	LIMIT 1;
SELECT customer_id,
CASE
	WHEN (customer_id <= 100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
	ELSE 'Normal'
END
FROM customer;

SELECT customer_id,
CASE customer_id
	WHEN 2 THEN '1st'
	WHEN 5 THEN '2nd'
	ELSE 'Normal'
END AS raffle_results
FROM customer;


SELECT * FROM film;
SELECT first_name, last_name, email FROM film;
SELECT * FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating='R';
SELECT COUNT(*) FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating='R';
SELECT description FROM film WHERE title='Outlaw Hanky'; 
SELECT title, length FROM film ORDER BY length ASC LIMIT 5; 
SELECT title FROM film WHERE length <= 50 ORDER BY length;
SELECT COUNT(*) FROM film WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;
SELECT COUNT(*) FROM film WHERE title LIKE '%Truman%';
SELECT 
	MIN(replacement_cost) AS minimum, 
	MAX(replacement_cost) AS maximum, 
	ROUND(AVG(replacement_cost), 2) AS average FROM film;
SELECT COUNT(*) FROM film WHERE title LIKE 'J%';
SELECT
SUM(
CASE rating
	WHEN 'R' THEN 1 ELSE 0
	END
) AS r,
SUM(
CASE rating
	WHEN 'PG' THEN 1 ELSE 0
	END
) AS pg,
SUM(
CASE rating
	WHEN 'PG-13' THEN 1 ELSE 0
	END
) AS pg13
FROM film;

SELECT * FROM address;
SELECT phone FROM address WHERE address='259 Ipoh Drive';
SELECT COUNT(DISTINCT district) FROM address;
SELECT DISTINCT district FROM address ORDER BY district;
SELECT district, email FROM address 
	INNER JOIN customer ON address.address_id = customer.address_id 
	WHERE district = 'California';

SELECT film.film_id, film.title, inventory_id, store_id FROM film 
	LEFT JOIN inventory ON inventory.film_id = film.film_id 
	WHERE inventory.film_id IS null;
SELECT title, first_name, last_name FROM film_actor 
	INNER JOIN actor ON actor.actor_id = film_actor.actor_id 
	INNER JOIN film ON film.film_id = film_actor.film_id 
	WHERE first_name = 'Nick' AND last_name = 'Wahlberg';

SELECT EXTRACT(MONTH FROM payment_date) AS pay_month FROM payment;
SELECT AGE(payment_date) FROM payment;
SELECT TO_CHAR(payment_date, 'MM/dd/YY') FROM payment;
SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH')) FROM payment;
SELECT COUNT(*) FROM payment WHERE EXTRACT(dow FROM payment_date) = 1;
SELECT ROUND(rental_rate/replacement_cost, 2)*100 AS percent_cost FROM film;
SELECT (UPPER(first_name) || ' ' || UPPER(last_name)) AS full_name FROM customer;
SELECT lower(LEFT(first_name, 1)) || lower(last_name) || '@gmail.com' AS custom_email FROM customer;
SELECT title, rental_rate FROM  film 
	WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);
SELECT film_id, title FROM film 
	WHERE film_id IN (SELECT inventory.film_id FROM  rental 
	INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id 
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30') 
	ORDER BY film_id;
SELECT last_name, first_name  FROM customer AS c 
	WHERE EXISTS (SELECT * FROM payment AS p WHERE p.customer_id = c.customer_id AND amount > 11) 
	ORDER BY last_name;
SELECT f1.title, f2.title, f1.length FROM film AS f1 
	INNER JOIN film AS f2 ON f1.film_id != f2.film_id AND f1.length = f2.length;

SELECT * FROM cd.facilities;
SELECT name, membercost FROM cd.facilities;
SELECT * FROM cd.facilities WHERE membercost > 0;
SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities 
	WHERE membercost > 0 AND membercost < (monthlymaintenance/50);
SELECT * FROM cd.facilities WHERE name LIKE 'Tennis%' OR name LIKE '%Tennis';
SELECT * FROM cd.facilities WHERE facid IN (1,5);
SELECT memid, surname, firstname, joindate FROM cd.members WHERE joindate >= '2012-09-01';
SELECT DISTINCT surname FROM cd.members ORDER BY surname ASC LIMIT 10;
SELECT joindate FROM cd.members ORDER BY joindate DESC LIMIT 1;
SELECT facid, sum(slots) AS "Total Slots" FROM cd.bookings 
	WHERE starttime >= '2012-09-01' AND starttime < '2012-10-01' 
	GROUP BY facid 
	ORDER BY SUM(slots);
SELECT facid, sum(slots) AS total_slots FROM cd.bookings 
	GROUP BY facid HAVING SUM(slots) > 1000 
	ORDER BY facid;
SELECT cd.bookings.starttime AS start, cd.facilities.name AS name FROM cd.facilities 
	INNER JOIN cd.bookings ON cd.facilities.facid = cd.bookings.facid 
	WHERE cd.facilities.facid IN (0,1) AND cd.bookings.starttime >= '2012-09-21' 
	AND cd.bookings.starttime < '2012-09-22' 
	ORDER BY cd.bookings.starttime;
SELECT cd.bookings.starttime FROM cd.bookings 
	INNER JOIN cd.members ON cd.members.memid = cd.bookings.memid 
	WHERE cd.members.firstname='David' AND cd.members.surname='Farrell';

CREATE TABLE students(
student_id serial PRIMARY KEY,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL, 
homeroom_number integer,
phone VARCHAR(20) UNIQUE NOT NULL,
email VARCHAR(115) UNIQUE,
grad_year integer);

CREATE TABLE teachers(
teacher_id serial PRIMARY KEY,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL, 
homeroom_number integer,
department VARCHAR(45),
email VARCHAR(20) UNIQUE,
phone VARCHAR(20) UNIQUE);

INSERT INTO students(first_name,last_name, homeroom_number,phone,grad_year)VALUES ('Mark','Watney',5,'7755551234',2035);
INSERT INTO teachers(first_name,last_name, homeroom_number,department,email,phone)VALUES ('Jonas','Salk',5,'Biology','jsalk@school.org','7755554321');
