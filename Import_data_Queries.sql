CREATE TABLE sales_store_raw (
    transaction_id     TEXT,
    customer_id        TEXT,
    customer_name      TEXT,
    customer_age       TEXT,
    gender             TEXT,
    product_id         TEXT,
    product_name       TEXT,
    product_category   TEXT,
    quantity           TEXT,
    price              TEXT,
    payment_mode       TEXT,
    purchase_date      TEXT,
    time_of_purchase   TEXT,
    status             TEXT
);
drop table sales_store;

select * from sales_store_raw;

COPY sales_store_raw
FROM 'D:/Data Analyst/SQL/sales_store/sales_store_data.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE sales_store (
    transaction_id     VARCHAR(20) PRIMARY KEY,
    customer_id        VARCHAR(20),
    customer_name      VARCHAR(100),
    customer_age       INT,
    gender             VARCHAR(10),
    product_id         VARCHAR(20),
    product_name       VARCHAR(100),
    product_category   VARCHAR(50),
    quantity           INT,
    price              DECIMAL(10,2),
    payment_mode       VARCHAR(50),
    purchase_date      DATE,
    time_of_purchase   TIME,
    status             VARCHAR(20)
);

select * from sales_store_raw;


SELECT *
FROM sales_store_raw
WHERE transaction_id IS NULL;

delete from sales_store_raw where transaction_id is null;


INSERT INTO sales_store (
    transaction_id, customer_id, customer_name, customer_age, gender,
    product_id, product_name, product_category, quantity, price,
    payment_mode, purchase_date, time_of_purchase, status
)
SELECT
    transaction_id,
    customer_id,
    customer_name,
    customer_age::INT,
    gender,
    product_id,
    product_name,
    product_category,
    quantity::INT,
    price::DECIMAL,
    payment_mode,
    TO_DATE(purchase_date, 'DD/MM/YYYY'),
    TO_TIMESTAMP(time_of_purchase, 'HH24:MI:SS')::TIME,
    status
FROM sales_store_raw;



select * from sales_store;

--Backup
SELECT *
INTO backup
FROM sales_store;



