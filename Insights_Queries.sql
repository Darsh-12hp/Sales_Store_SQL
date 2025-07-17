--Buisness Insights

select * from sales_store;

--------------------DATA ANALYSIS------------------------------------

--1 : What are the Top 5 most selling product by quantity?
select product_name,sum(quantity)
from sales_store where status='delivered'
group by product_name 
order by sum(quantity) desc limit 5;

--2 : Which Product are Most Frequently canceled?
select product_name,count(*) Product_count_cancelled
 from sales_store where status ='cancelled'
 group by product_name
 order by Product_count_cancelled desc limit 5;

--3 : what time of the day has the highest number of purchases?

select 
	Case 
		when EXTRACT(HOUR FROM time_of_purchase)Between 0 and 5 then 'NIGHT'
		when EXTRACT(HOUR FROM time_of_purchase)Between 6 and 11 then 'MORNING'
		when EXTRACT(HOUR FROM time_of_purchase)Between 12 and 17 then 'AFTERNOON'
		when EXTRACT(HOUR FROM time_of_purchase)Between 18 and 23 then 'EVENING'
	end as 	Case 
		when EXTRACT(HOUR FROM time_of_purchase)Between 0 and 5 then 'NIGHT'
		when EXTRACT(HOUR FROM time_of_purchase)Between 6 and 11 then 'MORNING'
		when EXTRACT(HOUR FROM time_of_purchase)Between 12 and 17 then 'AFTERNOON'
		when EXTRACT(HOUR FROM time_of_purchase)Between 18 and 23 then 'EVENING'
	end ,
	count(*) total_order
	
	FROM sales_store 
	GROUP BY 
			time_of_day
	order by total_order desc;

--4 Who are the top 5 highest spending customers?
select * from sales_store;

select customer_name,sum(price * quantity) spends
from sales_store 
group by customer_name 
order by spends desc limit 5;


SELECT 
    customer_name, 
    TO_CHAR(spend, '₹FM999,999,999') AS spends
FROM (
    SELECT 
        customer_name, 
        SUM(price * quantity) AS spend
    FROM sales_store 
    GROUP BY customer_name
) AS sub
ORDER BY spend DESC 
LIMIT 5;


--5 : Which Product Category Generates highest Revenue?
select * from sales_store;

select product_category,sum(price * quantity) revenue
from sales_store
group by product_category 
order by revenue desc limit 5;

SELECT 
    product_category, 
    TO_CHAR(spend, '₹FM999,999,999') AS revenue
FROM (
    SELECT 
        product_category, 
        SUM(price * quantity) AS spend
    FROM sales_store 
    GROUP BY product_category
) AS sub
ORDER BY spend DESC 
LIMIT 5;

--6 : what is the return/cancellation rate per product category?
select * from sales_store;

--total
SELECT 
    product_category,
    COUNT(*) FILTER (WHERE status ILIKE 'Cancelled' OR status ILIKE 'Returned') AS cancelled_orders,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE status ILIKE 'Cancelled' OR status ILIKE 'Returned') / NULLIF(COUNT(*), 0),
        2
    ) || '%' AS cancellation_rate
FROM sales_store
GROUP BY product_category
ORDER BY 
    cancellation_rate DESC;

--Cancelled

SELECT 
    product_category,
    COUNT(*) FILTER (WHERE status ILIKE 'Cancelled') AS cancelled_orders,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE status ILIKE 'Cancelled') / NULLIF(COUNT(*), 0),
        2
    ) || '%' AS cancellation_rate
FROM sales_store
GROUP BY product_category
ORDER BY cancellation_rate DESC;

--returned
Select 
	Product_category,
		COunt(*) Filter(where status ilike 'returned')as returned_orders,
		count(*) as total_orders,
		ROUND(100*COunt(*) Filter(where status ilike 'returned')/NULLIF(COUNT(*),0),2 )||'%' AS Returned_rate
From sales_store
Group by Product_category
Order by Returned_rate Desc;


-- 7 : what is the Most preffered payment mode?
select * from sales_store;

select payment_mode,count(*) modetotal
	from sales_store
group by payment_mode
order by modetotal desc;


-- 8 : How Does age Group affect purchasing behavior?
select * from sales_store;

Select 
	CASE 
		when customer_age Between 18 AND 25 THEN '18-25'
		when customer_age Between 26 AND 35 THEN '26-35'
		when customer_age Between 36 AND 50 THEN '36-50'
		else '51+'
	end as customer_age,
	--SUM(price*quantity)as Total_purchase_Price
	 TO_CHAR(SUM(price * quantity), '₹FM999,99,99,990') AS total_purchase_price
From sales_store

Group by 
		CASE 
		when customer_age Between 18 AND 25 THEN '18-25'
		when customer_age Between 26 AND 35 THEN '26-35'
		when customer_age Between 36 AND 50 THEN '36-50'
		else '51+'
		end 

order by Total_purchase_Price desc;



--9 : What is the Monthly Sales Trends?
Select * from sales_store;

Select 
	TO_CHAR(purchase_date, 'YYYY-MM') AS year_month,
	TO_CHAR(SUM(price * quantity), '₹FM999,99,99,990') as Total_sales,
	Sum(Quantity)as Total_Quantity
FROM Sales_store
Group by TO_CHAR(purchase_date, 'YYYY-MM');



--10 : Are Certain Genders buying more specific product  categories?
select * from sales_store;


Select Gender,Product_category,count(product_category) as Total_purchase
From sales_store
Group by gender,product_category
order by total_purchase desc;
	
