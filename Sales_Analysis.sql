-- =========================================================
-- BASIC DATA VALIDATION
-- =========================================================

SELECT *
FROM Sales
LIMIT 10;

-- =========================================================
-- CHECK NULL VALUES
-- =========================================================

SELECT *
FROM Sales
WHERE order_id IS NULL
   OR product IS NULL
   OR sales IS NULL
   OR city IS NULL;

-- =========================================================
-- CHECK DUPLICATES
-- =========================================================

SELECT 
    order_id,
    COUNT(*) AS duplicate_count
FROM Sales
GROUP BY order_id
HAVING COUNT(*) > 1;

-- =========================================================
-- INVALID SALES CHECK
-- =========================================================

SELECT *
FROM Sales
WHERE sales <= 0;

-- =========================================================
-- INVALID PRICE CHECK
-- =========================================================

SELECT *
FROM Sales
WHERE price_each <= 0;

-- =========================================================
-- INVALID QUANTITY CHECK
-- =========================================================

SELECT *
FROM Sales
WHERE quantity_ordered <= 0;

-- =========================================================
-- TOTAL SALES KPI
-- =========================================================

SELECT 
    ROUND(SUM(sales),2) AS total_sales
FROM Sales;

-- =========================================================
-- TOTAL ITEMS SOLD KPI
-- =========================================================

SELECT 
    SUM(quantity_ordered) AS total_items_sold
FROM Sales;

-- =========================================================
-- AVERAGE ORDER VALUE KPI
-- =========================================================

SELECT 
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM Sales;

-- =========================================================
-- UNIQUE PRODUCTS COUNT
-- =========================================================

SELECT 
    COUNT(DISTINCT product) AS unique_products
FROM Sales;

-- =========================================================
-- UNIQUE CITIES COUNT
-- =========================================================

SELECT 
    COUNT(DISTINCT city) AS unique_cities
FROM Sales;

-- =========================================================
-- MONTHLY SALES ANALYSIS
-- =========================================================

SELECT 
    month,
    ROUND(SUM(sales),2) AS total_sales
FROM Sales
GROUP BY month
ORDER BY total_sales DESC;

-- =========================================================
-- DAILY SALES TREND
-- =========================================================

SELECT 
    DATE(order_date) AS order_day,
    ROUND(SUM(sales),2) AS daily_sales
FROM Sales
GROUP BY order_day
ORDER BY order_day;

-- =========================================================
-- HOURLY SALES TREND
-- =========================================================

SELECT 
    hour,
    ROUND(SUM(sales),2) AS hourly_sales
FROM Sales
GROUP BY hour
ORDER BY hourly_sales DESC;

-- =========================================================
-- TOP 5 PRODUCTS
-- =========================================================

SELECT 
    product,
    ROUND(SUM(sales),2) AS total_revenue
FROM Sales
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 5;

-- =========================================================
-- MOST SOLD PRODUCTS
-- =========================================================

SELECT 
    product,
    SUM(quantity_ordered) AS total_quantity
FROM Sales
GROUP BY product
ORDER BY total_quantity DESC;

-- =========================================================
-- CITY SALES PERFORMANCE
-- =========================================================

SELECT 
    city,
    ROUND(SUM(sales),2) AS city_sales
FROM Sales
GROUP BY city
ORDER BY city_sales DESC;

-- =========================================================
-- ORDERS COUNT BY CITY
-- =========================================================

SELECT 
    city,
    COUNT(order_id) AS total_orders
FROM Sales
GROUP BY city
ORDER BY total_orders DESC;

-- =========================================================
-- REVENUE BY PRODUCT & CITY
-- =========================================================

SELECT 
    city,
    product,
    ROUND(SUM(sales),2) AS revenue
FROM Sales
GROUP BY city, product
ORDER BY revenue DESC;

-- =========================================================
-- CTE + WINDOW FUNCTION
-- MONTHLY SALES RANKING
-- =========================================================

WITH monthly_sales AS (

    SELECT 
        month,
        ROUND(SUM(sales),2) AS total_sales
    FROM Sales
    GROUP BY month

)

SELECT 
    month,
    total_sales,

    RANK() OVER(
        ORDER BY total_sales DESC
    ) AS sales_rank

FROM monthly_sales;

-- =========================================================
-- CTE + WINDOW FUNCTION
-- TOP PRODUCT RANKING
-- =========================================================

WITH product_sales AS (

    SELECT 
        product,
        ROUND(SUM(sales),2) AS revenue
    FROM Sales
    GROUP BY product

)

SELECT 
    product,
    revenue,

    DENSE_RANK() OVER(
        ORDER BY revenue DESC
    ) AS revenue_rank

FROM product_sales;

-- =========================================================
-- CTE + WINDOW FUNCTION
-- CITY SALES CONTRIBUTION %
-- =========================================================

WITH city_sales AS (

    SELECT 
        city,
        ROUND(SUM(sales),2) AS total_sales
    FROM Sales
    GROUP BY city

)

SELECT 
    city,
    total_sales,

    ROUND(

        (total_sales * 100.0)

        /

        SUM(total_sales) OVER(),

        2

    ) AS contribution_percentage

FROM city_sales

ORDER BY total_sales DESC;

-- =========================================================
-- RUNNING TOTAL SALES
-- =========================================================

WITH daily_sales AS (

    SELECT 
        DATE(order_date) AS order_day,
        ROUND(SUM(sales),2) AS daily_sales
    FROM Sales
    GROUP BY DATE(order_date)

)

SELECT 
    order_day,
    daily_sales,

    SUM(daily_sales) OVER(
        ORDER BY order_day
    ) AS running_total_sales

FROM daily_sales;

-- =========================================================
-- MOVING AVERAGE SALES
-- =========================================================

WITH daily_sales AS (

    SELECT 
        DATE(order_date) AS order_day,
        ROUND(SUM(sales),2) AS daily_sales
    FROM Sales
    GROUP BY DATE(order_date)

)

SELECT 
    order_day,
    daily_sales,

    ROUND(

        AVG(daily_sales) OVER(

            ORDER BY order_day

            ROWS BETWEEN 6 PRECEDING 
            AND CURRENT ROW

        ),

        2

    ) AS moving_avg_7_days

FROM daily_sales;

-- =========================================================
-- MONTH OVER MONTH GROWTH
-- =========================================================

WITH monthly_sales AS (

    SELECT 
        month,
        ROUND(SUM(sales),2) AS total_sales
    FROM Sales
    GROUP BY month

)

SELECT 
    month,
    total_sales,

    LAG(total_sales) OVER(
        ORDER BY total_sales
    ) AS previous_month_sales,

    ROUND(

        (
            total_sales -

            LAG(total_sales) OVER(
                ORDER BY total_sales
            )

        )

        /

        LAG(total_sales) OVER(
            ORDER BY total_sales
        )

        * 100,

        2

    ) AS growth_percentage

FROM monthly_sales;

-- =========================================================
-- BEST PRODUCT IN EACH CITY
-- =========================================================

WITH city_product_sales AS (

    SELECT 
        city,
        product,
        ROUND(SUM(sales),2) AS total_sales
    FROM Sales
    GROUP BY city, product

)

SELECT *

FROM (

    SELECT 
        city,
        product,
        total_sales,

        ROW_NUMBER() OVER(

            PARTITION BY city

            ORDER BY total_sales DESC

        ) AS row_num

    FROM city_product_sales

) ranked_products

WHERE row_num = 1;

-- =========================================================
-- SALES QUARTILE SEGMENTATION
-- =========================================================

WITH order_sales AS (

    SELECT 
        order_id,
        ROUND(SUM(sales),2) AS total_order_sales
    FROM Sales
    GROUP BY order_id

)

SELECT 
    order_id,
    total_order_sales,

    NTILE(4) OVER(
        ORDER BY total_order_sales DESC
    ) AS sales_segment

FROM order_sales;

-- =========================================================
-- CUMULATIVE PRODUCT REVENUE
-- =========================================================

WITH product_revenue AS (

    SELECT 
        product,
        ROUND(SUM(sales),2) AS revenue
    FROM Sales
    GROUP BY product

)

SELECT 
    product,
    revenue,

    SUM(revenue) OVER(
        ORDER BY revenue DESC
    ) AS cumulative_revenue

FROM product_revenue;

-- =========================================================
-- FIND OUTLIERS USING STDDEV
-- =========================================================

WITH sales_statistics AS (

    SELECT 
        AVG(sales) AS avg_sales,
        STDDEV(sales) AS std_sales
    FROM Sales

)

SELECT 
    s.*

FROM Sales s
CROSS JOIN sales_statistics st

WHERE s.sales >

(st.avg_sales + (2 * st.std_sales));

-- =========================================================
-- PRODUCT PERFORMANCE CLASSIFICATION
-- =========================================================

WITH product_sales AS (

    SELECT 
        product,
        ROUND(SUM(sales),2) AS revenue
    FROM Sales
    GROUP BY product

)

SELECT 
    product,
    revenue,

    CASE

        WHEN revenue >= 500000
        THEN 'High Performer'

        WHEN revenue >= 200000
        THEN 'Medium Performer'

        ELSE 'Low Performer'

    END AS performance_category,

    RANK() OVER(
        ORDER BY revenue DESC
    ) AS product_rank

FROM product_sales;

-- =========================================================
-- CUSTOMER PURCHASE FREQUENCY
-- =========================================================

WITH customer_orders AS (

    SELECT 
        purchase_address,
        COUNT(order_id) AS total_orders,
        ROUND(SUM(sales),2) AS total_spent
    FROM Sales
    GROUP BY purchase_address

)

SELECT 
    purchase_address,
    total_orders,
    total_spent,

    DENSE_RANK() OVER(
        ORDER BY total_spent DESC
    ) AS customer_rank

FROM customer_orders;

-- =========================================================
-- PEAK SALES HOUR
-- =========================================================

WITH hourly_sales AS (

    SELECT 
        hour,
        ROUND(SUM(sales),2) AS total_sales
    FROM Sales
    GROUP BY hour

)

SELECT 
    hour,
    total_sales,

    RANK() OVER(
        ORDER BY total_sales DESC
    ) AS sales_rank

FROM hourly_sales;

-- =========================================================
-- FINAL DASHBOARD DATASET
-- =========================================================

WITH final_dashboard AS (

    SELECT 
        month,
        city,
        product,

        SUM(quantity_ordered) AS total_quantity,

        ROUND(SUM(sales),2) AS total_sales

    FROM Sales

    GROUP BY 
        month,
        city,
        product

)

SELECT *

FROM final_dashboard

ORDER BY total_sales DESC;