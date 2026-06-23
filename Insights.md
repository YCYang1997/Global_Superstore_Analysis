# Business Problem

The company wants to understand international sales performance, identify underperforming regions, and improve profitability through data-driven insights.


# Tools Used

- Excel: Exploratory analysis
- SQLite: Data querying and aggregation
- Power BI: Dashboard visualization


# Data Quality Investigation

No fully duplicated rows were identified during the data quality check process.

The Postal Code column contained 80% missing values. Instead of immediately removing the column, a missing-value indicator variable was created to investigate whether missing postal codes were associated with shipping performance. Shipping performance is measured by the days needed from placing an order to shipping, a new column [shipping_days] is created by subtracting Ship Date from Order Date.

The analysis showed that the missing value ratio remained consistently around 80% across all shipping-day groups, suggesting that the presence or absence of postal codes was not associated with shipping duration.


# Key Findings

Across the four-year period, shipping day remained consistently under seven days after placing the order, with a average of 3.97 days, suggesting a stable fulfillment process.

Total profit demonstrated an overall upward trend over time. However, a recurring decline was observed in July, which may indicate a seasonal fluctuation in business performance.

APAC was identified as the most profitable market followed by EU. The United States was identified as the most profitable country, while New York generated the highest profit among all cities. While Armenia has the highest profit margin followed by Mauritania, 29 countries showed negative profit margins despite generating sales revenue. In addition, 675 out of 3788 products showed negative profit margin, indicating potential pricing or operational inefficiencies.

Technology is the most profitable category in terms of sales, profit, and profit margin. The profit margin of furniture is significantly lower than technology and office supplies products.

The repeat purchase rate is 99.37%, suggesting exceptionally strong customer loyalty and a high likelihood of customers returning for future purchases.
