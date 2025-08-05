create table pizza 
(
	pizza_id int,
	order_id int,
	pizza_name_id varchar(50),
	quantity int,
	order_date date,
	order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(50),
	pizza_category varchar(50),
	pizza_ingredients varchar(200),
	pizza_name varchar(50)
);

			-- Total Revenue
select round(sum(total_price)::numeric,2) as total_revenue
from pizza;

			-- Average Order Value
			
select round((sum(total_price) / count(distinct(order_id)))::numeric,2) as Avg_Order_Value 
from pizza;

			-- Total Pizza Sold
select sum(quantity) as Total_Pizza_Sold 
from pizza;


			-- Total Orders
select count(distinct(order_id)) as Total_Order 
from pizza;


			-- Average Pizza per Order

select round((sum(quantity)::numeric / count(distinct(order_id))),2) as Avg_Pizza_Order
from pizza;


			-- Daily Trends for Orders

select To_char(order_date, 'Day') as Order_day, count(distinct(order_id)) as Total_order
from pizza
group by Order_day
order by Total_order desc;


			-- Monthly Trends for Orders
select To_char(order_date, 'Month') as Order_day, count(distinct(order_id)) as Total_order
from pizza
group by Order_day
order by Total_order desc;


			-- % of sale by category
		
select 
	pizza_category,
	round(sum(total_price)::numeric,2) as revenue,
	round((sum(total_price) / sum(sum(total_price)) over ())::numeric * 100, 2) as percentage_share
from pizza
group by pizza_category;


			-- % of sale by pizza size

select pizza_size, 
	round(sum(total_price)::numeric, 2) as revenue,
	round((sum(total_price) / sum(sum(total_price)) over())::numeric * 100, 2) as percentage_size_share
from pizza 
group by pizza_size
order by percentage_size_share desc;

			-- Total pizza sold by category

select pizza_category, sum(quantity)  as total_qty_sold
from pizza
group by pizza_category
order by total_qty_sold desc;


			-- Top 5 Pizza by Revenue
		
select pizza_name, round(sum(total_price)::numeric, 2)  as revenue
from pizza
group by pizza_name
order by revenue desc
limit 5;

			-- Bottom 5 Pizza by Revenue

select pizza_name, round(sum(total_price)::numeric, 2)  as revenue
from pizza
group by pizza_name
order by revenue asc
limit 5;


			-- Top 5 Pizza by Quantity

select pizza_name, sum(quantity) as Total_Quantity
from pizza
group by pizza_name
order by Total_Quantity desc
limit 5;

			-- Bottom 5 Pizza by Quantity

select pizza_name, sum(quantity) as Total_Quantity
from pizza
group by pizza_name
order by Total_Quantity 
limit 5;

			-- Top 5 Pizza by Total Order

select pizza_name, count(distinct order_id) as Total_order
from pizza
group by pizza_name
order by Total_order desc
limit 5;

			-- Bottom 5 Pizza by Total Order
		
select pizza_name, count(distinct order_id) as Total_order
from pizza
group by pizza_name
order by Total_order asc
limit 5;
