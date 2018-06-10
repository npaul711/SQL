#1 Find the film title and language of all films in which ADAM GRANT acted
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)

SELECT film.title, language.name 
FROM film
JOIN language ON language.language_id = film.language_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'Adam' AND actor.last_name = 'Grant'
GROUP BY film.title
ORDER BY title DESC;

#2 We want to find out how many of each category of film ED CHASE has started in so return a table with category.name and the count
#of the number of films that ED was in which were in that category order by the category name ascending

SELECT DISTINCT COUNT(film.title) AS Number, name
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name LIKE 'ED'
AND actor.last_name LIKE 'CHASE'
GROUP BY name
ORDER BY category.name ASC;

#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result shoudl list the names of actors and the total lenght of Sci-Fi films they have been in

SELECT actor.first_name, actor.last_name, 
SUM(CASE WHEN category.name = "Sci-Fi" THEN film.length ELSE 0 END) AS Length 
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY actor.last_name, actor.first_name;

#4 Find the first name and last name of all actors who have never been in a Sci-Fi film

SELECT actor.first_name, actor.last_name 
FROM actor
JOIN film_actor ON film_actor.actor_id = actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name NOT IN
(SELECT category.name FROM category WHERE category.name = 'Sci-Fi')
GROUP BY actor.last_name;

#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies

SELECT film.title 
FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.first_name = 'KIRSTEN' AND actor.last_name = 'PALTROW';
