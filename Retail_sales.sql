DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );


SELECT * from retail_sales;


--How many sales are there in total?
select count(*) from retail_sales;

--How many sales are there with missing transactions_id?
select * from retail_sales where transaction_id is null;
select * from retail_sales where sale_date is null;
select * from retail_sales where sale_time is null;

select * from retail_sales where customer_id is null;

select * from retail_sales where gender is null;

SELECT * 
FROM retail_sales
WHERE transaction_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR gender IS NULL
  OR category IS NULL
  OR quantity IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;

delete from retail_sales
where transaction_id is null
	or sale_date is null
	OR sale_time IS NULL
  OR gender IS NULL
  OR category IS NULL
  OR quantity IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;

select * from retail_sales;

--How many sales are there in total?
select count(*) as total_sale
from retail_sales;

-- How many unique customers are there?
select count(distinct customer_id) as total_sale
from retail_sales;

--What are the distinct categories of products sold?
select distinct category from retail_sales;


--Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select * from retail_sales
where sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
select * from retail_sales
where category = 'Clothing'
	and to_char(sale_date, 'YYYY-MM') = '2022-11'
	AND quantity >=4;

-- Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as net_sale,
				count(*) as total_orders
	from retail_sales
	group by category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000;

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(*) as total_trans
from retail_sales
group by category, gender
order by category desc;


--Write a SQL query to find the top 5 customers based on the highest total sales.
select customer_id, sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc
limit 5;

--Write a SQL query to find the number of unique customers who purchased items from each category
select category, count(distinct customer_id) as cnt_cust_id
from retail_sales
group by category;

--Write a SQL query to create shifts and number of orders (e.g., Morning <12, Afternoon between 12 & 17, Evening >17).
WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

