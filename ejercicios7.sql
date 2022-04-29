-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC), 
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

/* Para la región con las ventas más grandes total_amt_usd, ¿cuántos pedidos en total se realizaron?*/
WITH t1 AS(
	SELECT r.name estado, SUM(o.total_amt_usd) sumatoria
	FROM region r
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a
	ON a.sales_rep_id = s.id
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY estado
	),
	t2 AS ( SELECT MAX(t1.sumatoria)
	FROM t1
	)
SELECT r.name estado, count(o.total) cantidad
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY estado
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

-- Para la cuenta que compró la mayor cantidad (en total durante su vida como cliente) de papel 'std_qty', 
-- ¿cuántas cuentas aún tenían más en compras totales?

WITH t1 AS(
	SELECT a.name, SUM(o.standard_qty) cantidad1, SUM(o.total) cantidad2
	FROM orders o
	JOIN accounts a
	ON o.account_id = a.id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1),
	 t2 AS(
	SELECT a.name, SUM(o.total) cantidad2
	FROM orders o
	JOIN accounts a
	ON o.account_id = a.id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT cantidad2 FROM t1)
	 )
SELECT COUNT(*) cantidad
FROM t2

-- Para el cliente que gastó más (en total durante su vida como cliente) 'total_amt_usd', 
-- ¿cuántos eventos web tuvo para cada canal?

WITH t1 AS(
	SELECT a.id, a.name, SUM(total_amt_usd) compras_max
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1,2 
	ORDER BY 3 DESC
	LIMIT 1)

SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id = (SELECT id FROM t1)
GROUP BY 1,2
ORDER BY 3 desc

-- ¿Cuál es el monto promedio de por vida gastado en términos de 'total_amt_usd' para las 10 principales 
-- cuentas de gasto total?
WITH t1 AS (
SELECT a.name, SUM(o.total_amt_usd) total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY total DESC
LIMIT 10)
SELECT AVG(total) promedio
FROM t1

-- ¿Cuál es el monto promedio de por vida gastado en términos de 'total_amt_usd', incluidas solo las empresas 
-- que gastaron más por pedido, en promedio, que el promedio de todos los pedidos?
WITH t1 AS (
	SELECT AVG(o.total_amt_usd) media
	FROM orders o),
	t2 AS (
	SELECT o.account_id, AVG(o.total_amt_usd) promedio
	FROM orders o
	GROUP BY 1
	HAVING promedio > (SELECT * FROM t1))

SELECT AVG(promedio)
FROM t2



