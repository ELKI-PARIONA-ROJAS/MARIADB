-- Find the sales in terms of total dollars for all orders in each year, 
-- from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT year(occurred_at) AS año, sum(total_amt_usd) ventas
FROM orders
GROUP BY año 

-- Which month did Parch & Posey have the greatest sales in terms of total dollars? 
-- Are all months evenly represented by the dataset?
SELECT month(occurred_at) AS mes, sum(total_amt_usd) ventas
FROM orders
GROUP BY mes
ORDER BY ventas DESC
LIMIT 1

SELECT month(occurred_at) AS mes, year(occurred_at) AS año, sum(total_amt_usd) ventas
FROM orders
GROUP BY año, mes
ORDER BY ventas DESC
LIMIT 1

-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all years evenly represented by the dataset?
SELECT year(occurred_at) AS año, sum(total) cantidad
FROM orders
GROUP BY año 
ORDER BY cantidad DESC
LIMIT 1

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all months evenly represented by the dataset?
SELECT month(occurred_at) AS mes, sum(total) cantidad
FROM orders
GROUP BY mes
ORDER BY cantidad DESC
LIMIT 1

SELECT month(occurred_at) AS mes, year(occurred_at) AS año, sum(total) cantidad
FROM orders
GROUP BY año, mes
ORDER BY cantidad DESC
LIMIT 1

-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT month(occurred_at) AS mes, sum(gloss_amt_usd) papel_satinado
FROM orders
GROUP BY mes
ORDER BY papel_satinado DESC
LIMIT 1

SELECT month(occurred_at) AS mes, year(occurred_at) AS año, sum(gloss_amt_usd) papel_satinado
FROM orders
GROUP BY año, mes
ORDER BY papel_satinado DESC
LIMIT 1

