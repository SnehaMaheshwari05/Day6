create database pizzahut;
use pizzahut;

select * FROM pizzas;

create table orders(
order_id int not null primary key,
order_date date not null,
order_time time not null
);

select * FROM orders;

create table order_detail(
order_details_id int not null  primary key ,
order_id int not null,
pizza_id text not null,
qty int not null
);


# Retrieve the total number of orders
select count(order_id) as total_orders from orders;

# calc the total revenue generated from pizza sales

SELECT 
    ROUND(SUM(qty * price), 2) AS total_revenue
FROM
    order_detail
        JOIN
    pizzas ON order_detail.pizza_id = pizzas.pizza_id;
    
# identify the highest_price pizza

SELECT 
    name, price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1
;

# identify the most common pizza size ordered

SELECT 
    size, COUNT(qty) AS order_count
FROM
    pizzas
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY size
ORDER BY order_count DESC
LIMIT 1
;

# list the top 5 most ordered pizza types along with their quantity

SELECT 
    name, (SUM(qty)) AS qty_ordered
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY name
ORDER BY qty_ordered DESC
LIMIT 5
;

# determine the distribution of orders by hour of the day

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS qty_ordered
FROM
    orders
GROUP BY hour
ORDER BY hour ;

# join the relevant tables to find the category wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category
;

SELECT 
    ROUND(AVG(qty_ordered), 0) AS avg_pizza_odr_per_day
FROM
    (SELECT 
        order_date AS date, SUM(qty) AS qty_ordered
    FROM
        orders
    JOIN order_detail ON orders.order_id = order_detail.order_id
    GROUP BY date) AS data
;
# calc the % contribution of each pizza type to total revenue
SELECT 
    category,
    ROUND(100 * (SUM(price * qty) / (SELECT 
                    SUM(qty * price) AS total_sales
                FROM
                    order_detail
                        JOIN
                    pizzas ON order_detail.pizza_id = pizzas.pizza_id)),
            2) AS perc_contribution
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY category
;

# ANALYZE THE CUMULATIVE REVENUE GENERATED OVER TIME 
select order_date,sum(revenue) over(order by order_date)from(
select order_date  ,sum(qty*price) as revenue
from orders
join order_detail
on orders.order_id=order_detail.order_id 
join pizzas
on order_detail.pizza_id = pizzas.pizza_id 
group by order_date
order by order_date)as cum_revenue
;

# determine the top 3 most ordered pizza types based on revenue for each pizza category
# using subqueries and rank

select name,rn from
(select category,name,revenue,( rank() over(partition by category order by revenue desc )) as rn from(
select category,name ,sum(qty*price) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_detail
on pizzas.pizza_id =order_detail.pizza_id
group by category,name) as a)as b
where rn<=3
;
















