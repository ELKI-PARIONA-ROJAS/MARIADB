-- How many of the sales reps have more than 5 accounts that they manage?

SELECT  s.name, count(a.name) cantidad
from accounts a 
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING cantidad > 5

-- How many accounts have more than 20 orders?
SELECT  a.id, COUNT(o.account_id) cantidad
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
HAVING cantidad > 20


-- Which account has the most orders?
SELECT  a.id, COUNT(o.account_id) cantidad
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
ORDER BY cantidad desc
LIMIT 1

-- Which accounts spent more than 30,000 usd total across all orders?
SELECT  a.id, SUM(o.total_amt_usd) monto
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
HAVING monto > 30000

-- Which accounts spent less than 1,000 usd total across all orders?
SELECT  a.id, SUM(o.total_amt_usd) monto
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
HAVING monto < 1000

-- Which account has spent the most with us?
SELECT  a.id, sum(o.total_amt_usd) monto
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
ORDER BY monto desc
LIMIT 1

-- Which account has spent the least with us?
SELECT  a.id, sum(o.total_amt_usd) monto
FROM orders o
JOIN accounts a 
ON o.account_id = a.id
GROUP BY a.id
ORDER BY monto 
LIMIT 1

-- Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT account_id, CHANNEL, COUNT(channel) cantidad 
FROM web_events 
WHERE CHANNEL = 'facebook'
GROUP BY account_id 
HAVING cantidad > 6

-- Which account used facebook most as a channel?
SELECT account_id, CHANNEL, COUNT(channel) cantidad 
FROM web_events 
WHERE CHANNEL = 'facebook'
GROUP BY account_id 
ORDER BY cantidad desc
LIMIT 1

-- Which channel was most frequently used by most accounts?
SELECT CHANNEL, account_id, COUNT(account_id) cantidad 
FROM web_events 
GROUP BY channel 
ORDER BY cantidad desc
LIMIT 1

