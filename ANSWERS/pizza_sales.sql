use [Pizza-DB]

select*from pizza_sales
-- KPI’s
--1. Total Revenue:
select sum(total_price)as Total_Revenue
from pizza_sales

--2. Average Order Value
select sum(total_price)/count(distinct(order_id)) as Avg_order_value
from pizza_sales

--3. Total Pizzas Sold
select sum(quantity) as Total_pizza_sold
from pizza_sales

--4. Total Orders
select count(distinct(order_id))as Total_orders
from pizza_sales

--5. Average Pizzas Per Order
select cast(sum(quantity)/count(distinct(order_id))as decimal(10,2)) as Avg_pizza_per_order
from pizza_sales
-----------------------------------------------
--Charts:
--Daily Trend
select datename(dw,order_date)as order_day, count(distinct(order_id))as Total_order
from pizza_sales
group by datename(dw,order_date)

--Hourly Trend
select DATEPART(hour,order_time)as order_hours,count(distinct(order_id))as Total_orders
from pizza_sales
group by DATEPART(hour,order_time)
order by Total_orders desc

--percentage os sales by pizza category
select pizza_category,cast(sum(total_price) as decimal(10,2)) as Total_sales,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date)=1) as decimal(10,2))as Percentage_of_sales
from pizza_sales
where month(order_date)=1
group by pizza_category 

--percentage os sales by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_sales,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1) as decimal(10,2))as Percentage_of_sales
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by Percentage_of_sales desc

--Total Pizza Sold By Pizza Category
select pizza_category, sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_category

--Top 5 Best Sellers by Total Pizzas Sold
select top 5 pizza_name,sum(quantity)as total_pizza_sold
from pizza_sales
group by pizza_name 
order by total_pizza_sold desc

--Bottom 5 Best Sellers by Total Pizzas Sold
select top 5 pizza_name,sum(quantity)as total_pizza_sold
from pizza_sales
where month(order_date)=1
group by pizza_name 
order by total_pizza_sold 
