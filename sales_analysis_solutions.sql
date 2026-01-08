
use sql_project_1;
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
            
select * from retail_sales where transaction_id = 180;
select * from retail_sales limit 10;
select * from retail_sales 
where age is null or gender is null ;

select * from retail_sales; 

-- How many uniuque customers we have ?

select count(distinct customer_id) as count_customer from retail_sales ;

select distinct category from retail_sales ;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



select * from retail_sales where sale_date = "2022-11-05";

select * from retail_sales where category = "Clothing" and quantity >= 4 and sale_date >= "2022-11-01" and sale_date <"2022-12-01";

select category , sum(total_sale) as total_sale_per_category,count(*) as count_category from retail_sales group by category;

select category , avg(age) as avg_age from retail_sales where category = "Beauty";

select * from retail_sales where total_sale > 1000;

select gender,category,count(transaction_id) as count_of_id from retail_sales group by gender,category ;

select * from (
select year(sale_date) as 'year' ,
month(sale_date) as 'month',
avg(total_sale) as 'avg_month' ,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) DESC) as rn
from retail_sales 
group by year,month 
order by year,avg_month desc
)x
where x.rn = 1;

select customer_id,sum(total_sale) as total from retail_sales group by customer_id order by total desc limit 5;

select category,count(distinct customer_id) as count_distinct_id from retail_sales group by category;

select *,sale_time,case when hour(sale_time) <= 12 then "Morning" 
when hour(sale_time) between 12 and 17 then "Afternoon"
when hour(sale_time) > 17 then "Evening" end as shift
from retail_sales ;