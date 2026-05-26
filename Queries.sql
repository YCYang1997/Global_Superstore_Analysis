/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Check whether data is imported successfully
*/

SELECT
	*
FROM
	Orders
LIMIT 5


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Count total transactions
*/

SELECT
	COUNT(*) AS total_rows
FROM
	Orders


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: See distinct markets
*/

SELECT
	DISTINCT Market
FROM
	Orders

	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Sales, profit, profit margin by market
*/

SELECT
    Market,   
    ROUND(SUM(sales) / 1000.0, 2) || 'K' AS total_sales_k,
    ROUND(SUM(profit) / 1000.0, 2) || 'K' AS total_profit_k,
	ROUND(SUM(profit) * 100.0 / SUM(sales), 2) || '%' AS profit_margin
FROM orders
GROUP BY Market
ORDER BY SUM(sales) DESC

	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Sales, profit, profit margin by country
*/

SELECT
    Country,   
    ROUND(SUM(sales) / 1000.0, 2) || 'K' AS total_sales_k,
    ROUND(SUM(profit) / 1000.0, 2) || 'K' AS total_profit_k,
	ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin
FROM orders
GROUP BY Country
ORDER BY profit_margin DESC	


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: 10 most profitable countries
*/

SELECT
    Country AS [10 most profitable countries],   
    ROUND(SUM(sales) / 1000.0, 2) AS total_sales_k,
    ROUND(SUM(profit) / 1000.0, 2) AS total_profit_k,
	ROUND(SUM(profit) * 100.0 / SUM(sales), 2) || '%'  AS profit_margin
FROM orders
GROUP BY Country
ORDER BY total_profit_k DESC
LIMIT 10


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: 10 most profitable cities
*/

SELECT
    City AS [10 most profitable countries],   
    ROUND(SUM(sales) / 1000.0, 2) AS total_sales_k,
    ROUND(SUM(profit) / 1000.0, 2) AS total_profit_k,
	ROUND(SUM(profit) * 100.0 / SUM(sales), 2) || '%' AS profit_margin
FROM orders
GROUP BY City
ORDER BY total_profit_k DESC
LIMIT 10

	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: count negative profit margin countries
*/

SELECT
    COUNT(*) AS negative_profit_margin_countries
FROM (
    SELECT
        Country,
        ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin
    FROM orders
    GROUP BY Country
	)
WHERE profit_margin < 0
	

/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Sales, profit, profit margin by category
*/

SELECT
    category,
    ROUND(SUM(sales) / 1000.0, 2) AS total_sales_k,
    ROUND(SUM(profit) / 1000.0, 2) AS total_profit_k,
	ROUND(SUM(profit) * 100.0 / SUM(sales), 2) || '%' AS profit_margin
FROM orders
GROUP BY category
ORDER BY total_sales_k DESC


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Cleaned dates view
*/

CREATE VIEW Cleaned_Dates AS
SELECT
    *,
	substr("order date", 7, 4) || '-' ||
    substr("order date", 4, 2) || '-' ||
    substr("order date", 1, 2)
    AS clean_order_date,
    substr("Ship date", 7, 4) || '-' ||
    substr("Ship date", 4, 2) || '-' ||
    substr("Ship date", 1, 2)
    AS clean_ship_date,
    
	julianday(
        substr("Ship date", 7, 4) || '-' ||
        substr("Ship date", 4, 2) || '-' ||
        substr("Ship date", 1, 2)
    )
    -
    julianday(
        substr("order date", 7, 4) || '-' ||
        substr("order date", 4, 2) || '-' ||
        substr("order date", 1, 2)
    )
    AS shipping_days
FROM orders
	
	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Min, max, average shipping days
*/

SELECT
	MIN(shipping_days),
	MAX(shipping_days),
	round(avg(shipping_days),2)
FROM
	Cleaned_Dates


/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Average shipping day by shipping mode
*/

SELECT
	"Ship mode",
	round(avg(shipping_days),2) AS Avg_Shipping_Day
FROM
	Cleaned_Dates
GROUP BY "Ship mode"
	
	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Average shipping day by region
*/

SELECT
	Region,
	round(avg(shipping_days),2) AS Avg_Shipping_Day
FROM
	Cleaned_Dates
GROUP BY Region
	
	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Total sales by month
*/

SELECT
    strftime('%Y-%m', clean_order_date) AS order_month,
    ROUND(SUM(sales) / 1000.0, 2) AS total_sales_k
FROM Cleaned_Dates
GROUP BY order_month
ORDER BY order_month
	
/*
CREATED BY: Gina Yang
CREATE DATE: 2026/05/26
DESCRIPTION: Total profit by month
*/

SELECT
    strftime('%Y-%m', clean_order_date) AS order_month,
    ROUND(SUM(profit) / 1000.0, 2) AS total_profit
FROM Cleaned_Dates
GROUP BY order_month
ORDER BY order_month