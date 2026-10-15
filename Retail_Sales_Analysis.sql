## 1.Database Setup

CREATE DATABASE sql_project1;

CREATE TABLE retail_sale
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

### 2.Data Exploration & Cleaning

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;




### 3. Data Analysis & Findings

-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05.
use 
sql_project1 ; 
SELECT *
FROM retail_sale
WHERE sale_date = '2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022.

select * from retail_sale
  where category = 'Clothing'
    and 
	sale_date >= '2022-11-01' 
	and
	sale_date < '2022-12-01' 
    and 
    quantiy >=4 ;
   
 
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sale
GROUP BY  category;


-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select ROUND (avg(age),2) from retail_sale 
where category = 'Beauty';


-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sale 
where total_sale > 1000 ;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category , gender, count(*) as total_transaction from retail_sale 
group by 
category ,
gender ; 


-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


SELECT
    years,
    months,
    avg_sale,
    sales_rank
from ( select
	YEAR(sale_date) as YEARS ,
	MONTH(sale_date) as MONTHS ,
	ROUND (AVG(total_sale), 2) as avg_sale ,
RANK() OVER( 
	partition by YEAR(sale_date)
	order by avg(total_sale) DESC
	)as sales_rank
from retail_sale 
group by YEARS , MONTHS
)AS t1 
where sales_rank = 1 ;


SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sale
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE sales_rank = 1;



-- 8.Write a SQL query to find the top 5 customers based on the highest total sales .

select customer_id , SUM(total_sale) AS total_sale 
from retail_sale
GROUP BY customer_id 
ORDER BY total_sale DESC 
LIMIT 5 

;


-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT category , COUNT(DISTINCT customer_id )FROM retail_sale
GROUP BY category ; 

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening .
WITH hourly_sale
AS (
select * ,
 CASE 
	WHEN HOUR(sale_time) <12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17  THEN 'AFTERNOON'
    ELSE 'Evening'
 END AS shift 
FROM retail_sale )

SELECT shift ,COUNT(*) as total_order 
FROM  hourly_sale
GROUP BY shift ;
 
 
## Reports

--  **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
-- **Trend Analysis**: Insights into sales trends across different months and shifts.
-- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

-- This project covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. 
-- The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



