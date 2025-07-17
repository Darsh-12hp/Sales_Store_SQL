
--Backup
SELECT *
INTO backup
FROM sales_store;


--Data cleaning

--Check Duplicate

Select * from sales_store;

--checking the count duplicates
select transaction_id,count(*)
from sales_store 
Group by transaction_id
Having count(*)>1;

--checking the values by row_num
with CTE as
(select *, 
		Row_number() over(partition by transaction_id order by transaction_id)as row_num
From sales_store
)
Select * from CTE where  transaction_id IN ('TXN342128','TXN855235','TXN981773')

--Delete Duplicate Rows
with CTE as
(select *, 
		Row_number() over(partition by transaction_id order by transaction_id)as row_num
From sales_store
)
Select * from CTE where row_num=2;


--Checking Data Type
SELECT column_name,data_type 
	FROM information_schema.columns
	where table_name='sales_store';

--check null counts
SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS transaction_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS customer_name_nulls,
    COUNT(*) FILTER (WHERE customer_age IS NULL) AS customer_age_nulls,
    COUNT(*) FILTER (WHERE gender IS NULL) AS gender_nulls,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS product_id_nulls,
    COUNT(*) FILTER (WHERE product_name IS NULL) AS product_name_nulls,
    COUNT(*) FILTER (WHERE product_category IS NULL) AS product_category_nulls,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_nulls,
    COUNT(*) FILTER (WHERE price IS NULL) AS price_nulls,
    COUNT(*) FILTER (WHERE payment_mode IS NULL) AS payment_mode_nulls,
    COUNT(*) FILTER (WHERE purchase_date IS NULL) AS purchase_date_nulls,
    COUNT(*) FILTER (WHERE time_of_purchase IS NULL) AS time_of_purchase_nulls,
    COUNT(*) FILTER (WHERE status IS NULL) AS status_nulls
FROM sales_store;

--Handling Null Values
--customer_id
select * from sales_store where customer_id is null;

select * from sales_store where customer_name = 'Ehsaan Ram';
Update  sales_store set customer_id='CUST9494'  where transaction_id='TXN977900';

select * from sales_store where customer_name = 'Damini Raju';
Update  sales_store set customer_id='CUST1401'  where transaction_id='TXN985663';

--customer_age
select * from sales_store where customer_age is null; 

select * from sales_store where customer_id ='CUST1003'; 

update sales_store set customer_age='35' where transaction_id='TXN432798'

--customer_name
select * from sales_store where customer_name is null;

select * from sales_store where customer_id='CUST1003';

update sales_store set customer_name='Mahika Saini' where transaction_id='TXN432798';

--gender

select * from sales_store where gender is null;

select * from sales_store where customer_id='CUST1003';

update sales_store set gender='Male' where transaction_id='TXN432798';


select * from sales_store;
--Cleaning In gender column
select  distinct gender from sales_store ;

Update sales_store
SET gender=CASE
			when gender='M' Then 'Male'
			when gender='F' Then 'Female'
			Else gender 
		end
	where gender IN('M','F')

--clean Payment_mode column
select distinct payment_mode from sales_store;

Update sales_store
	set payment_mode=Case
		when payment_mode='CC' then 'Credit Card'
		else payment_mode
	end
where payment_mode IN('CC');


