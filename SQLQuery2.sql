select *from pizza_sales;

-- 1.) Total Revenue

select sum(total_price) as Total_Revenue
from pizza_sales;

-- 2,) Average Order Value:

select sum(total_price) / count(distinct order_id) as Avg_Order_Value
from pizza_sales;

-- 3.) Total Pizzas Per Order

select sum(quantity) as total_pizza_sold
from pizza_sales;

-- 4.) Total Orders

select count(distinct order_id) as Total_Order
from pizza_sales;

-- 5.) Average Pizzas Per Order

select cast(cast(sum(quantity) as Decimal(10,2))/ 
cast(count(order_id) as decimal(10,2)) as decimal(10,2))
as Avg_Pizza_Per_Order from pizza_sales;

-- 6.) Daily Trend for Total Order( Per Pizza) (DW - Date Week)

select datename(dw, order_date) as order_day, 
count(distinct order_id) as Total_orders
from pizza_sales
group by datename(dw, order_date);

-- 7.) Hour Trend  for Toal Order (Per Pizza)

select Datepart(hour, order_time) as order_hours,
count(distinct order_id) as Total_orders
from pizza_sales
group by Datepart(hour, order_time);

-- 8.) Percentage of Sales by Pizza Category

SELECT pizza_category, sum(total_price) as Total_Sales,
sum(total_price) *100 /
(select sum(total_price) from pizza_sales where month(order_date)=1) as Percent_Of_Total_sales
from pizza_sales
where month(order_date)=1 -- month 1 for jan
group by pizza_category;
-- group by here use categorical dimention

-- 9.) Percentage of Sales by Pizza Size

SELECT pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales,
cast(sum(total_price) *100 /
(select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2)) as Percent_Of_Total_sales
from pizza_sales -- cast is use for converting decimal
where datepart(quarter, order_date)=1
group by pizza_size
order by Percent_Of_Total_sales DESC;

-- 10.) Total Pizzas Sold by Pizza Category

select sum(quantity),pizza_category as Total_Pizza_Sold
from pizza_sales
group by pizza_category

-- 11.) Top 5 Best Sellers by Total Pizzas Sold

select top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) DESC

-- 12.) Bottom 5 Best Sellers by Total Pizzas Sold

select Top 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
where month(order_date) = 8 -- 8 is aug month
group by pizza_name
order by sum(quantity) ASC