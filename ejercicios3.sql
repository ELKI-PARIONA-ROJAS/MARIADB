-- Write a query to display for each order, the account ID, total amount of the order, 
-- and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, 
-- or smaller than $3000.
SELECT account_id, total_amt_usd, 
case 
	when total_amt_usd < 3000 then 'pequeño'
	when total_amt_usd >= 3000 then 'grande'
END AS 'nivel_pedidos'
FROM orders

SELECT account_id, sum(total_amt_usd) total_ventas, 
case 
	when sum(total_amt_usd) < 3000 then 'pequeño'
	when sum(total_amt_usd) >= 3000 then 'grande'
END AS 'nivel_pedidos'
FROM orders
GROUP BY account_id
ORDER BY total_ventas

-- Write a query to display the number of orders in each of three categories, based on the total number 
-- of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT account_id, 
case 
	when total > 2000 then 'grande'
	when total BETWEEN 1000 AND 2000 then 'mediano'
	ELSE 'pequeño'
END AS nivel_pedidos,
COUNT(*) AS cantidad
FROM orders
GROUP BY nivel_pedidos

SELECT account_id, SUM(total) cantidad, 
case 
	when sum(total) > 2000 then 'grande'
	when sum(total) BETWEEN 1000 AND 2000 then 'mediano'
	ELSE 'pequeño'
END AS nivel_pedidos
FROM orders
GROUP BY account_id
ORDER BY cantidad

-- We would like to understand 3 different levels of customers based on the amount associated with their purchases. 
-- The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
-- The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. 
-- Provide a table that includes the level associated with each account. You should provide the account name, 
-- the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name, SUM(o.total_amt_usd) AS total_ventas,
case 
when sum(o.total_amt_usd) > 200000 then 'grandes'
when sum(o.total_amt_usd) BETWEEN 100000 AND 200000 then 'medianos'
ELSE 'pequeños'
END AS clientes
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_ventas

/* We would now like to perform a similar calculation to the first, but we want to obtain the total amount 
spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the 
top spending customers listed first.*/
SELECT a.name, SUM(o.total_amt_usd) AS total_ventas,
case 
when sum(o.total_amt_usd) > 200000 then 'grandes'
when sum(o.total_amt_usd) BETWEEN 100000 AND 200000 then 'medianos'
ELSE 'pequeños'
END AS clientes
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE YEAR(o.occurred_at) = 2016 OR YEAR(o.occurred_at) = 2017
GROUP BY a.name
ORDER BY total_ventas

/*We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. 
Create a table with the sales rep name, the total number of orders, and a column with top or not depending on 
if they have more than 200 orders. Place the top sales people first in your final table.
*/
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'Bueno'
     ELSE 'Malo' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY num_ords DESC


/* The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides 
they want to see these characteristics represented as well. We would like to identify top performing sales reps, 
which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has 
any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of 
orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. 
Place the top sales people based on dollar amount of sales first in your final table.
*/
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent, 
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'Alto'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'Medio'
     ELSE 'Bajo' END AS rendimiento
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY rendimiento DESC;























































































