-- 
SELECT CHANNEL, AVG(cantidad) AS promedio FROM 
(
	SELECT 
	DAY(occurred_ad) AS dia,
	CHANNEL,
	COUNT(channel) AS cantidad
	FROM web_events 
	GROUP BY dia, CHANNEL
	ORDER BY cantidad desc
) sub
GROUP BY CHANNEL
ORDER BY cantidad


-- 
SELECT *
	FROM orders
	WHERE MONTH(occurred_at) =
	(
	SELECT min(MONTH(occurred_at)) AS mes_minimo
	FROM orders
	)
	ORDER BY occurred_at


-- Ejercicios de subconsultas
SELECT min(month(occurred_at)) 
FROM orders;

SELECT AVG(standard_qty) avg_std, AVG(gloss_qty) avg_gls, AVG(poster_qty) avg_pst
FROM orders
WHERE month(occurred_at) = 
     (SELECT min(month(occurred_at)) FROM orders)

SELECT SUM(total_amt_usd)
FROM orders
WHERE month(occurred_at) = 
      (SELECT min(month(occurred_at)) FROM orders)

