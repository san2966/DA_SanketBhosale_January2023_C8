use sakila;
-- *******************************************************************************************************************************
-- TASK-1
-- Display the full names of actors avilable in the database
-- *******************************************************************************************************************************

select concat(first_name,' ',last_name)as Full_Name from actor;

-- *******************************************************************************************************************************
-- Task-2.1
-- Display the number of times each first names appear in database.
-- *******************************************************************************************************************************

select first_name, count(*) from actor group by first_name order by count(*) desc;

-- *******************************************************************************************************************************
-- Task-2.2
-- What is the count of actors that have unique first name in the database
-- Display the first name of all these actors
-- *******************************************************************************************************************************

select first_name, count(first_name) as count_first_name from actor 
group by first_name 
having count(first_name)=1;

-- *******************************************************************************************************************************
-- Task-3
-- The management is interasted to analyze the similarity in the last names of the actors
-- Display the number of times each last names appears in the database
-- *******************************************************************************************************************************

Select last_name, count(*) from actor 
group by last_name 
order by count(*) desc;

-- *******************************************************************************************************************************
-- Task-3.2
-- Display all unique last names in the database.
-- *******************************************************************************************************************************

select last_name, count(last_name) as count_last_name from actor 
group by last_name 
having count(last_name)=1;

-- *******************************************************************************************************************************
-- Task-4:-
-- Display the list of records for the movies with the rating 'R'
-- *******************************************************************************************************************************

select * from film 
where rating='R';

-- *******************************************************************************************************************************
-- Task-4.2
-- Display the list for the movies that are not rated 'R'
-- *******************************************************************************************************************************

select * From film 
where rating !='R';

-- *******************************************************************************************************************************
-- Task-4.3
-- Display the list of records for the movie that are suitable for audiance below 13 years of age
-- *******************************************************************************************************************************

select * from film 
where rating = 'PG-13';

-- *******************************************************************************************************************************
-- Task-5:-
-- Display the list of records for the movies where the replacement cost is up to $11.
-- *******************************************************************************************************************************

select * from film 
where replacement_cost>=11;

-- *******************************************************************************************************************************
-- Task-5.2:-
-- Display the list of records for the movies where the replacement cost is between $11 and $20
-- *******************************************************************************************************************************

select * from film 
Where replacement_cost between 11 and 20;

-- *******************************************************************************************************************************
-- Display the list of records for the all movies in descending order of their replacement cost
-- *******************************************************************************************************************************

select * from film 
order by replacement_cost desc;

-- *******************************************************************************************************************************
-- Task-6:-
-- Display the names of the top 3 movies with the greatest number of actors
-- *******************************************************************************************************************************

select title, count(*) as count_actor 
from film join film_actor 
using(film_id) 
group by film.film_id 
order by count_actor desc 
limit 3;

-- *******************************************************************************************************************************
-- Task-7:-
-- 'Music of Queen' and 'kris kristofferson' have seen an unlikely resurgence. As an unintended
-- Consequence, films starting with the letters 'K' and 'Q' have also soared in popularity.
-- Display the titles of the movie starting with letter 'K' and 'Q'
-- *******************************************************************************************************************************

select title from film 
where title like'K%' or 
title like 'Q%';

-- *******************************************************************************************************************************
-- Task-8:-
-- The film 'Agent Truman' has been a great success.
-- Display the names of all actors who appeared in this film
-- *******************************************************************************************************************************

select title, first_name, last_name from actor 
join film_actor using (actor_id) 
join film using (film_id) 
where title='Agent Truman';

-- *******************************************************************************************************************************
-- Task-9:-
-- Sales have been lagging among young families, so the managements wants to promote family movies.
-- Identify all the movies categorized as family film
-- *******************************************************************************************************************************

select title, category.name from film 
join film_category using(film_id) 
join category using(category_id) 
where name='Family';

-- *******************************************************************************************************************************
-- Task-10.1
-- Display the maximum, minimum and average rental rates of movies based on their ratings.
-- The output must be sorted in descending order of the average rental rates
-- *******************************************************************************************************************************

select rating, max(rental_rate), 
min(rental_rate), 
avg(rental_rate) from film 
group by rating 
order by avg(rental_rate) desc;

-- *******************************************************************************************************************************
-- Task-10.2
-- Display the movies in descending order of their rental frequencies.
-- so, the management can maintain more copies of those movies
-- *******************************************************************************************************************************

select title, 
count(rental_id) as rental_frequency 
from film join inventory using (film_id) 
join rental using(inventory_id) 
group by film_id 
order by rental_frequency desc;

-- *******************************************************************************************************************************
-- Task-11
-- In how many film categories, the difference between the average film replacement cost(disc-DVD/Blue Ray)
-- The average film rental rate is greater than $15
-- *******************************************************************************************************************************

select cat.name as category_name, 
avg(f.replacement_cost) as average_replacement_cost, 
avg(f.rental_rate) as average_rental_rate 
from film f join film_category using(film_id) 
join category cat using (category_id) 
join inventory using(film_id) 
join rental using (inventory_id)
group by category_name 
having (avg(f.replacement_cost)-avg(f.rental_rate))>15;

-- *******************************************************************************************************************************
-- Task-12:-
-- Display the film categories which the number of movies is grater than 70
-- *******************************************************************************************************************************

select cat.name, count(title) from film 
join film_category using(film_id)
join category cat using(category_id) 
group by cat.name 
having count(title) >= 70;

-- *********************************************** THE END ***********************************************************************
