/*

-----------------------------------------------------------------------------------------------------------------------------------
													    Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			

-----------------------------------------------------------------------------------------------------------------------------------
                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  use project_newwheels;
  select * from customer_t;
  select * from order_t;
  select * from product_t;
  select * from shipper_t;
  
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/
select state,count(customer_id) from customer_t
group by state;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.*/

ALTER TABLE order_t ADD COLUMN rating_numeric INT;

SET SQL_SAFE_UPDATES = 0;


UPDATE order_t
SET rating_numeric = CASE 
    WHEN customer_feedback= 'Very Bad' THEN 1
    WHEN customer_feedback= 'Bad' THEN 2
    WHEN customer_feedback= 'Okay' THEN 3
    WHEN customer_feedback= 'Good' THEN 4
    WHEN customer_feedback= 'Very Good' THEN 5
    ELSE NULL  -- Handle unexpected values
END;

select * from order_t;

SELECT quarter_number, round(AVG(rating_numeric),1) AS average_rating
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;






-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. 
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  And find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.*/
SELECT quarter_number,customer_feedback,COUNT(*) AS feedback_count,(COUNT(*) * 100.0 / SUM(COUNT(*))
OVER (PARTITION BY quarter_number)) AS percentage_feedback
FROM order_t
GROUP BY quarter_number, customer_feedback
ORDER BY quarter_number, FIELD(customer_feedback, 'Very Bad', 'Bad', 'Okay', 'Good', 'Very Good');

      


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/


select p.vehicle_maker,count(c.customer_id) as count_customer
from product_t as p
join order_t as o
on p.product_id=o.product_id
join customer_t as c
on o.customer_id=c.customer_id
group by p.vehicle_maker
order by count_customer desc
limit 5;




-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle maker in each state?*/



SELECT c.state, p.vehicle_maker, COUNT(o.order_id) AS order_count
FROM customer_t c
JOIN order_t o ON c.customer_id = o.customer_id
JOIN product_t p ON o.product_id = p.product_id
GROUP BY c.state, p.vehicle_maker
HAVING order_count = (
    SELECT MAX(order_count)
    FROM (
        SELECT c.state, p.vehicle_maker, COUNT(o.order_id) AS order_count
        FROM customer_t c
        JOIN order_t o ON c.customer_id = o.customer_id
        JOIN product_t p ON o.product_id = p.product_id
        GROUP BY c.state, p.vehicle_maker
    ) AS subquery
    WHERE subquery.state = c.state
)ORDER BY c.state;

-- ---------------------------------2nd way-------------------------------------------
WITH vehicle_counts AS (
    SELECT 
        c.state,
        p.vehicle_maker,
        COUNT(o.order_id) AS order_count,
        RANK() OVER (PARTITION BY c.state ORDER BY COUNT(o.order_id) DESC) AS rank_no
    FROM customer_t c
    JOIN order_t o ON c.customer_id = o.customer_id
    JOIN product_t p ON o.product_id = p.product_id
    GROUP BY c.state, p.vehicle_maker
)
SELECT state, vehicle_maker, order_count
FROM vehicle_counts
WHERE rank_no = 1;



-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/
select * from order_t;

SELECT quarter_number,count(order_id) AS count_of_order
FROM order_t
GROUP BY  quarter_number
ORDER BY quarter_number;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.*/
  WITH revenue_per_quarter AS (
    SELECT 
        quarter_number,
        SUM(vehicle_price * (1 - discount)) AS total_revenue
    FROM order_t
    GROUP BY quarter_number
)
SELECT 
    quarter_number,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY quarter_number) AS previous_quarter_revenue,
    CASE 
        WHEN LAG(total_revenue) OVER (ORDER BY quarter_number) IS NOT NULL 
        THEN ((total_revenue - LAG(total_revenue) OVER (ORDER BY quarter_number)) / LAG(total_revenue) OVER (ORDER BY quarter_number)) * 100
        ELSE NULL
    END AS qoq_percentage_change
FROM revenue_per_quarter;

    


      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/
SELECT 
    quarter_number,
    SUM(vehicle_price * (1 - discount)) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/


SELECT 
    c.credit_card_type,
    round(AVG(o.vehicle_price * o.discount),2) AS avg_discount_amount
FROM customer_t c
JOIN order_t o ON c.customer_id = o.customer_id
GROUP BY c.credit_card_type
ORDER BY avg_discount_amount DESC;

-- -------------------------2nd way-----------------------------------
SELECT 
    c.credit_card_type,
    AVG(o.discount) AS avg_discount
FROM customer_t c
JOIN order_t o ON c.customer_id = o.customer_id
GROUP BY c.credit_card_type
ORDER BY avg_discount DESC;






-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
	Hint: Use the dateiff function to find the difference between the ship date and the order date.
*/
SELECT 
    quarter_number,
    AVG(DATEDIFF(ship_date, order_date)) AS avg_shipping_time
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number;


-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



