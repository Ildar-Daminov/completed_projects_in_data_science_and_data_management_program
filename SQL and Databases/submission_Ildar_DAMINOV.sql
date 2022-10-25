/*	
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin with the project, you need to create the database first

-- Deleting the existing database if exists 
drop database if exists vehdb;

-- Create an empty data base 
create database vehdb;

-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.

-- Refer to vehdb
use vehdb;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/* List of tables to be created.

 Create a table temp_t, vehicles_t, order_t, customer_t, product_t, shipper_t */
 
 -- Drop temp_t if exists 
 DROP TABLE IF EXISTS temp_t;                     

-- Create the empty temp_t 
create table temp_t (
	shipper_id integer,  
	shipper_name varchar(50),
	shipper_contact_details varchar(30),
	product_id integer,
	vehicle_maker varchar(60),
	vehicle_model varchar(60),
	vehicle_color varchar(60),
	vehicle_model_year integer,
	vehicle_price decimal(14,2),
	quantity integer,
    discount decimal(4,2),
	customer_id varchar(25),
	customer_name varchar(25),
	gender varchar(15),
	job_title varchar(50),
	phone_number varchar(20),
	email_address varchar(50),
	city varchar(25),
	country varchar(40),
	state varchar(40),
	customer_address varchar(50),
	order_date date,
	order_id varchar(25),
	ship_date date,
	ship_mode varchar(25),
	shipping varchar(30),
	postal_code integer,
	credit_card_type varchar(40),
	credit_card_number bigint,
	customer_feedback varchar(20),
	quarter_number integer,
    primary key (shipper_id,product_id,order_id,customer_id)
);

 -- Drop vehicles_t if exists     
 DROP TABLE IF EXISTS vehicles_t;  

create table vehicles_t (
	shipper_id integer,  
	shipper_name varchar(50),
	shipper_contact_details varchar(30),
	product_id integer,
	vehicle_maker varchar(60),
	vehicle_model varchar(60),
	vehicle_color varchar(60),
	vehicle_model_year integer,
	vehicle_price decimal(14,2),
	quantity integer,
    discount decimal(4,2),
	customer_id varchar(25),
	customer_name varchar(25),
	gender varchar(15),
	job_title varchar(50),
	phone_number varchar(20),
	email_address varchar(50),
	city varchar(25),
	country varchar(40),
	state varchar(40),
	customer_address varchar(50),
	order_date date,
	order_id varchar(25),
	ship_date date,
	ship_mode varchar(25),
	shipping varchar(30),
	postal_code integer,
	credit_card_type varchar(40),
	credit_card_number bigint,
	customer_feedback varchar(20),
	quarter_number integer,
    primary key (shipper_id,product_id,order_id,customer_id)
);

-- Drop order_t if exists     
 DROP TABLE IF EXISTS order_t;                              
 
-- Create the empty order_t 
create table order_t (
	order_id varchar(25),
	customer_id varchar(25),
	shipper_id integer,  
	product_id integer,
	quantity integer,
	vehicle_price decimal(14,2), -- Attention: per ER diagram the vehicle_price in order_t  is decimal(10,2) and in product_t is decimal(14,2)! I took (14,2) as the longest name 
	order_date date,
	ship_date date,
	discount decimal(4,2),
	ship_mode varchar(25),
	shipping varchar(30),
	customer_feedback varchar(20),
	quarter_number integer,
    primary key (order_id)
);

-- Drop customer_t if exists     
 DROP TABLE IF EXISTS customer_t;  

-- Create the empty customer_t 
create table customer_t (
	customer_id varchar(25),
	customer_name varchar(25),
	gender varchar(15),
	job_title varchar(50),
	phone_number varchar(20),
	email_address varchar(50),
	city varchar(25),
	country varchar(40),
	state varchar(40),
	customer_address varchar(50),
	postal_code integer,
	credit_card_type varchar(40),
	credit_card_number bigint,
    primary key (customer_id)
);

-- Drop product_t if exists     
 DROP TABLE IF EXISTS product_t;  
 
-- Create the empty product_t 
create table product_t (
	product_id integer,
	vehicle_maker varchar(60),
	vehicle_model varchar(60),
	vehicle_color varchar(60),
	vehicle_model_year integer,
	vehicle_price decimal(14,2),
    primary key (product_id)
);

 -- Drop shipper_t if exists     
 DROP TABLE IF EXISTS shipper_t;  

-- Create the empty shipper_t 
create table shipper_t (
	shipper_id integer,  
	shipper_name varchar(50),
	shipper_contact_details varchar(30),
    primary key (shipper_id)
);
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:
/* List of stored procedures to be created.

   Creating the stored procedure for vehicles_p, order_p, customer_p, product_p, shipper_p*/

-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS vehicles_p;

DELIMITER $$
-- This procedure appends the data from temp_t into main table vehicles_t
CREATE PROCEDURE vehicles_p()
BEGIN
	INSERT INTO vehdb.vehicles_t (
		shipper_id,  
		shipper_name,
		shipper_contact_details,
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price,
		quantity,
        discount,
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city ,
		country,
		state,
		customer_address,
		order_date,
		order_id,
		ship_date,
		ship_mode,
		shipping,
		postal_code,
		credit_card_type,
		credit_card_number,
		customer_feedback,
		quarter_number
    ) 
    select * 
    from vehdb.temp_t ;
END;

-- CALL vehicles_p(); -- uncomment this statement if calling is needed 

-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS order_p;

DELIMITER $$
-- This procedure appends new orders into order_t
CREATE PROCEDURE order_p(n integer) -- n was illustrated in ER diagram. 
BEGIN
	INSERT INTO vehdb.order_t (
		order_id,
		customer_id,
		shipper_id,  
		product_id,
		quantity,
		vehicle_price, 
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number
		) 
    select distinct 
    	order_id,
		 customer_id,
		 shipper_id,  
		 product_id,
		 quantity,
		 vehicle_price, 
		 order_date,
		 ship_date,
		 discount,
		 ship_mode,
		 shipping,
		 customer_feedback,
		 quarter_number
    from vehdb.vehicles_t where quarter_number=n ;
END;

-- CALL order_p(4); -- uncomment this statement if calling is needed 

-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS customer_p;

DELIMITER $$
-- This procedure appends new customers into customer_t
CREATE PROCEDURE customer_p()
BEGIN
	INSERT INTO vehdb.customer_t (
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		postal_code,
		credit_card_type,
		credit_card_number
		) 
    select distinct 
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		postal_code,
		credit_card_type,
		credit_card_number
    from vehdb.vehicles_t where customer_id not in (select distinct customer_id from vehdb.customer_t);
END;

-- CALL customer_p(); -- uncomment this statement if calling is needed 

-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS product_p;

DELIMITER $$
-- This procedure appends new products into product_t
CREATE PROCEDURE product_p()
BEGIN
	INSERT INTO vehdb.product_t (
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
		) 
    select distinct 
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
    from vehdb.vehicles_t where product_id not in (select distinct product_id from vehdb.product_t);
END;

-- CALL product_p(); -- uncomment this statement if calling is needed 


-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS shipper_p;

DELIMITER $$
-- This procedure appends new shippers into shipper_t
CREATE PROCEDURE shipper_p()
BEGIN
	INSERT INTO vehdb.shipper_t (
		shipper_id,  
		shipper_name,
		shipper_contact_details
		) 
    select distinct 
		shipper_id,  
		shipper_name,
		shipper_contact_details
    from vehdb.vehicles_t where shipper_id not in (select distinct shipper_id from vehdb.shipper_t);
END;

-- CALL shipper_p(); -- uncomment this statement if calling is needed 

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:


-- Ingesting the data for 1 quarter 
TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "C:/Users/Ireena/Documents/_DSDM_Texas_GL/SQL/Project/Data/new_wheels_sales_qtr_1.csv" 
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(1);


-- Ingesting the data for 2 quarter 
TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "C:/Users/Ireena/Documents/_DSDM_Texas_GL/SQL/Project/Data/new_wheels_sales_qtr_2.csv" 
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(2);


-- Ingesting the data for 3 quarter 
TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "C:/Users/Ireena/Documents/_DSDM_Texas_GL/SQL/Project/Data/new_wheels_sales_qtr_3.csv" 
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(3);


-- Ingesting the data for 4 quarter 

TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "C:/Users/Ireena/Documents/_DSDM_Texas_GL/SQL/Project/Data/new_wheels_sales_qtr_4.csv" 
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(4);

/* Note: 

---> With the help of the above code, you can ingest the data into temp_t table by ingesting the quarterly data and by calling the stored 
     procedures you can ingest the data into separate table.
---> You have to run the above ingestion code 4 times as 4 quarters of data are present and you also need to call all the stored procedures 
     4 times. Please change the argument value while calling the stored procedure order_p(n). (n = 1,2,3,4)
---> If needed revisit the videos: Week 2: Data Modeling and Architecture: Ingesting data into the main table and Ingesting future weeks of data
---> Also revisit the codes used to ingest the data for the gl_eats database. 
     This will help in getting a better understanding of how to ingest the data into various respective tables.*/


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:
-- List of views to be created are "veh_prod_cust_v" , "veh_ord_cust_v"


-- To drop the views if already exists- 
DROP VIEW IF EXISTS veh_prod_cust_v;

create view veh_prod_cust_v as
	select
		cust.customer_id,
        cust.customer_name,
        cust.city,
        cust.credit_card_type,
        cust.state,
        ord.order_id,
        ord.customer_feedback,
		prod.product_id,
        prod.vehicle_maker,
        prod.vehicle_model,
        prod.vehicle_color,
        prod.vehicle_model_year
	from customer_t as cust
		inner join order_t as ord on cust.customer_id=ord.customer_id
		inner join product_t as prod on ord.product_id=prod.product_id;

-- To drop the views if already exists- 
DROP VIEW IF EXISTS veh_ord_cust_v;

create view veh_ord_cust_v as
	select
		cust.customer_id,
        cust.customer_name,
        cust.city,
        cust.state,
        cust.credit_card_type,
        ord.order_id,
		ord.shipper_id,
        ord.product_id,
        ord.quantity,
        ord.vehicle_price,
        ord.order_date,
        ord.ship_date,
        ord.discount,
        ord.customer_feedback,
        ord.quarter_number
	from customer_t as cust
		inner join order_t as ord
			on cust.customer_id=ord.customer_id;
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

-- Create the function calc_revenue_f

-- Syntax to create function-
-- Create the function days_to_ship_f-
Drop function if exists calc_revenue_f; 

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (vehicle_price decimal(14,2), discount decimal(4,2), quantity  int) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
	DECLARE revenue decimal(14,2);
	SET revenue=(vehicle_price*quantity)*(100-discount)/100;
	RETURN (revenue);
END;


-- Create the function days_to_ship_f-
Drop function if exists days_to_ship_f; 

DELIMITER $$
CREATE FUNCTION days_to_ship_f (order_date date, ship_date date) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  
	DECLARE days_to_ship int;
	SET days_to_ship=DATEDIFF(ship_date,order_date);
	RETURN (days_to_ship);
END;

/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/
select state,
       count(distinct customer_id) as CNT,
       sum(count(distinct customer_id)) over () as total_customers -- additional column for total_number of customers
from veh_ord_cust_v
group by 1
order by 2 desc;
-- Saved as Q1.csv (used in python)

-- Additonal study to see the customer distribution grouped by quarters
select state,
	   quarter_number,
       count(distinct customer_id) as CNT
from veh_ord_cust_v
group by 1,2
order by 1,2 asc;
-- Saved as Q1_1.csv (used in python)
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.
Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 
*/
-- Creating common table expression 
WITH CTE AS
(
	SELECT
    CUSTOMER_ID,
    ORDER_ID,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS,
        quarter_number
	FROM veh_ord_cust_v
)

-- Finding the answer for the question by using CTE
SELECT
	quarter_number,
    AVG(CUSTOMER_RATINGS) AS Average_rating
    FROM CTE
GROUP BY 1
ORDER by 1 asc;

-- Saved as Q2.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
*/

-- Creating the common table expressions
WITH CTE AS
(
	SELECT
    quarter_number,
    customer_feedback,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS
	FROM veh_ord_cust_v
)

-- Finding out the % of different types of customer feedback in each quarter
SELECT
	quarter_number,
    customer_feedback,
    COUNT(CUSTOMER_RATINGS) AS Number_of_ratings,
    sum(count(CUSTOMER_RATINGS)) over (partition by quarter_number) as Total_quarter_feedback -- additional column
    FROM CTE
GROUP BY 1,2
ORDER by 1,2 asc;

-- Saved as Q3.csv (used in python)

-- --------------------------Additonal study: the average rating of vehicle maker 
WITH CTE AS
(
	SELECT
        CUSTOMER_ID,
		ORDER_ID,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS,
        quarter_number,
        state,
        product_id
	FROM veh_ord_cust_v
)

-- Finding the answer for the question by using CTE
	SELECT
        prod.vehicle_maker,
		AVG(cte.CUSTOMER_RATINGS) AS Average_rating
		FROM CTE as cte
		INNER JOIN veh_prod_cust_v as prod
			on cte.product_id=prod.product_id	
	GROUP BY 1
	ORDER by 2 asc;
-- Saved as Q2_2.csv (used in python)
    
-- ----------------------- -- Additional study: average feedback value by state and  by quarter
-- Creating common table expression 
WITH CTE AS
(
	SELECT
    CUSTOMER_ID,
    ORDER_ID,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS,
        quarter_number,
        state
	FROM veh_ord_cust_v
)

-- Finding the answer for the question by using CTE
	SELECT
		state,
		quarter_number,
		AVG(CUSTOMER_RATINGS) AS Average_rating
		FROM CTE
	GROUP BY 1,2
	ORDER by 1,2 asc;
-- Saved as Q3_2.csv (used in python)

-- ------------------- Additional study:  average rating of each shipper
-- Creating the common table expressions
WITH CTE AS
(
	SELECT
    shipper_id,
    quarter_number,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS
	FROM veh_ord_cust_v
)

-- Finding out the % of different types of customer feedback in each quarter
SELECT
	ship.shipper_name,
	cte.quarter_number,
	AVG(cte.CUSTOMER_RATINGS) AS Average_rating
    FROM CTE as cte
		inner join shipper_t as ship
			on ship.shipper_id=cte.shipper_id
GROUP BY 1,2
ORDER by 1,2 asc;
-- Saved as Q3_3.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/

-- Finding the top 5 vehicle makers
select prod.vehicle_maker,
       count(*) as CNT
from veh_ord_cust_v as ord
	inner join veh_prod_cust_v as prod
		on ord.product_id=prod.product_id
group by 1
order by 2 desc;
-- Saved as Q4.csv (used in python)


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle maker in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

-- Creating the common table expressions
WITH CTE AS
(
	SELECT
    ord.state,
    prod.vehicle_maker,
    count(ord.customer_id) as customer_number
	FROM veh_ord_cust_v as ord
		INNER JOIN veh_prod_cust_v as prod
			on ord.customer_id=prod.customer_id
	group by ord.state,  prod.vehicle_maker

)

-- Calculating the ranking 
select * 
from (select *, rank() over(partition by state order by customer_number desc) as ranking from CTE) as alias_table
where ranking=1
order by 1 asc;
-- Saved as Q5.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/

-- Caclulating the number of orders by quarters
select quarter_number,
	   count(order_id) as number_of_orders
from veh_ord_cust_v 
group by 1
order by 1 asc; 
-- Saved as Q6.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
      
Note: For reference, refer to question number 5. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions and the LAG function from this question.*/

-- Creating the common table expressions
with CTE as 
(
select quarter_number,
	   sum(calc_revenue_f (vehicle_price, discount, quantity)) as revenue
from veh_ord_cust_v 
group by 1
order by 1 asc      
) 

-- Calculating the quarter over quarter % change in revenue
select *,
	   LAG(REVENUE) OVER (ORDER BY quarter_number) AS PREVIOUS_quarter_REVENUE,
       ((REVENUE - LAG(REVENUE) OVER (ORDER BY quarter_number))/LAG(REVENUE) OVER(ORDER BY quarter_number) * 100) AS "QoQ(%)"
from CTE

-- Saved as Q7.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/

-- Calculating the trend of revenue and orders by quarters
select quarter_number,
       count(order_id) as number_of_orders,
	   sum(calc_revenue_f (vehicle_price, discount, quantity)) as revenue
from veh_ord_cust_v 
group by 1
order by 1 asc; 
-- Saved as Q8.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/

-- Caclulating the average discount offered for different types of credit cards
select 
	credit_card_type,
    AVG(discount) as mean_dicsount
from veh_ord_cust_v 
group by 1
order by 2 desc;
-- Saved as Q9.csv (used in python)

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Hint: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/

-- Caclulating the average time taken to ship the placed orders for each quarters
select quarter_number,
	   AVG(delivery_time) as average_delivery_time
from (select quarter_number, days_to_ship_f(order_date,ship_date) as delivery_time from veh_ord_cust_v) as alias_table
group by quarter_number
order by quarter_number asc;
-- Saved as Q10.csv (used in python)

-- Checking if the delivery time may be a reason of low satisfaction 
WITH CTE AS
(
	SELECT
    state, 
    CUSTOMER_ID,
    ORDER_ID,
        CASE 
			WHEN customer_feedback ='Very Bad' THEN 1
            WHEN customer_feedback ='Bad' THEN 2
            WHEN customer_feedback ='Okay' THEN 3
            WHEN customer_feedback ='Good' THEN 4
            WHEN customer_feedback ='Very Good' THEN 5
		END AS CUSTOMER_RATINGS,
        quarter_number,
        days_to_ship_f(order_date,ship_date) as delivery_time
	FROM veh_ord_cust_v
)

-- Finding the answer for the question by using CTE
SELECT
	state,
    quarter_number,
    AVG(CUSTOMER_RATINGS) AS Average_rating,
    AVG(delivery_time) as average_delivery_time
    FROM CTE
GROUP BY 1,2
ORDER by 1,2 asc;
-- Saved as add_study_corr.csv (used in python)

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------