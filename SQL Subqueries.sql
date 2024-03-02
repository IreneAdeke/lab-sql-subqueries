use sakila; 
# 1. How many copies of the film Hunchback Impossible exist in the inventory system?
select * from film; 
select * from inventory; 

select count(inventory_id) from inventory i where i.film_id in
(select f.film_id from film f
join inventory i
on f.film_id = i.film_id
where f.title = "Hunchback Impossible"); # There are 6 copies of Hunchback impossible in Inventory

# 2. List all films whose length is longer than the average of all the films.
select * from film; 
select film_id, title, length from film where length > 
(select avg(length) as average_length from film); 

# 3. Use subqueries to display all actors who appear in the film Alone Trip.
select * from film; 
select * from actor; 
select * from film_actor; 

select concat(first_name,' ',last_name) as "Alone Trip Actors"
from actor
where actor_id in 
(select actor_id from film_actor where film_id = 
(select film_id from film where title = 'Alone Trip'));



# 4. Identify all movies categorized as family films.
select * from film; 
select * from category; 
select * from film_category; 

select title from film f where f.film_id in 
(select f.film_id, name
from film f
left join film_category on (f.film_id=film_category.film_id)
left join category on (film_category.category_id=category.category_id)
where category.name= "Family");

# 5. Get name and email from customers from Canada using subqueries.
select first_name,last_name,email
from customer
left join address on customer.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id=country.country_id
WHERE country='Canada';
 

# 6. Which are films starred by the most prolific actor
select * from film; 
select * from actor; 
select * from film_actor; 
select first_name, last_name from actor where actor_id = 107; 


select * from film_actor 
where actor_id =
(select actor_id from film_actor fa
join actor a using(actor_id)
group by actor_id
order by count(distinct film_id) desc
limit 1); 


# 7. Films rented by most profitable customer.
select * from customer; 
select * from payment; 
select * from rental; 
select * from film; 
select * from inventory; 


select * from rental 
where customer_id =
(select  p.customer_id from payment p
join customer c
on c.customer_id = p.customer_id
join rental r
on r.rental_id = p.rental_id
join inventory i using(inventory_id)
join film f using(film_id)
group by c.customer_id
order by sum(p.amount) desc
limit 1); 


# 8. Get the client_id and the total_amount_spent of those clients 
#who spent more than the average of the total_amount spent by each client.
select * from customer; 
select * from payment; 


select p.customer_id, first_name, last_name, sum(amount)
from payment p
join customer c 
on p.customer_id = c.customer_id
group by customer_id
having sum(amount) > (select avg(amount) as total_amount from payment); 



 