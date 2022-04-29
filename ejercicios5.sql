/* Proporcione el nombre del representante de ventas en cada región con la mayor cantidad de ventas totales_amt_usd.
- Primero, quería encontrar los totales de total_amt_usd asociados con cada representante de ventas, 
y también quería la región en la que estaban ubicados. La siguiente consulta proporcionó esta información.
- Luego, saqué el máximo para cada región y luego podemos usar esto para sacar esas filas en nuestro resultado final.
- Esencialmente, esto es un JOIN de estas dos tablas, donde la región y la cantidad coinciden.*/

SELECT t3.nombre, t3.regiones, t3.total
FROM (SELECT reg_nombre, MAX(totalito) maximo
      FROM (SELECT r.name reg_nombre, s.name sal_nombre, SUM(total_amt_usd) totalito
            FROM region r
            JOIN sales_reps s
            ON r.id = s.region_id
            JOIN accounts a
            ON a.sales_rep_id = s.id
            JOIN orders o
            ON o.account_id = a.id
            GROUP BY 1,2) t1
      GROUP BY reg_nombre) t2
JOIN (SELECT s.name nombre, r.name regiones, SUM(total_amt_usd) total
      FROM region r
      JOIN sales_reps s
      ON r.id = s.region_id
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY 1,2
      ) t3
ON t2.reg_nombre = t3.regiones AND t2.maximo = t3.total


/* Para la región con las ventas más grandes total_amt_usd, ¿cuántos pedidos en total se realizaron?
- La primera consulta que escribí fue extraer el total_amt_usd para cada región.
- Entonces solo queremos la región con la cantidad máxima de esta tabla. Hay dos formas en las que consideré 
obtener esta cantidad. Una era sacar el máximo usando una subconsulta. Otra forma es ordenar descendentemente 
y simplemente extraer el valor superior.
- Finalmente, queremos sacar el total de pedidos para la región con esta cantidad:*/

SELECT r.name, SUM(o.total_amt_usd) sumita
      FROM region r
      JOIN sales_reps s
      ON r.id = s.region_id
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY r.name
      HAVING sumita = (SELECT max(sumita)
            FROM (SELECT r.name, SUM(o.total_amt_usd) sumita
                  FROM region r
                  JOIN sales_reps s
                  ON r.id = s.region_id
                  JOIN accounts a
                  ON a.sales_rep_id = s.id
                  JOIN orders o
                  ON o.account_id = a.id
                  GROUP BY r.name
                  ) sub)


/* ¿Cuántas cuentas tuvieron más compras totales que el nombre de la cuenta que compró la mayor cantidad de papel 
'standard_qty' a lo largo de su vida como cliente?
- Primero, queremos encontrar la cuenta que tenía la mayor cantidad de papel 'standard_qty'. La consulta 
aquí extrae esa cuenta, así como la cantidad total:
- Ahora, quiero usar esto para extraer todas las cuentas con más ventas totales:
- Esta es ahora una lista de todas las cuentas con más pedidos totales. Podemos obtener el conteo con solo 
otra subconsulta simple.*/

SELECT COUNT(*) 
	FROM (
	SELECT a.name
	FROM accounts a
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY a.name 
	HAVING SUM(o.total) > (
            SELECT suma FROM(
                  SELECT a.name, SUM(o.standard_qty) sumita, SUM(o.total) suma
                  FROM accounts a
                  JOIN orders o
                  ON a.id = o.account_id
                  GROUP BY 1
                  ORDER BY 2 DESC 
                  LIMIT 1) sub)
	) totales

/* Para el cliente que gastó más (en total durante su vida como cliente) 'total_amt_usd', 
¿cuántos eventos web tuvo para cada canal?
- Aquí, primero queremos atraer al cliente con el valor de vida más gastado.
- Ahora, queremos ver la cantidad de eventos en cada canal que tuvo esta empresa, que podemos comparar 
solo con la identificación.
- Agregué un ORDEN POR sin motivo real, y el nombre de la cuenta para asegurarme de que solo estaba 
extrayendo de una cuenta.*/

SELECT a.name, w.channel, COUNT(*) suma
FROM accounts a
JOIN web_events w
ON w.account_id = a.id AND a.id = (
	SELECT id FROM (
            SELECT a.id, a.name, SUM(o.total_amt_usd) suma
            FROM orders o
            JOIN accounts a
            ON o.account_id = a.id
            GROUP BY a.id, a.name
            ORDER BY suma DESC 
            LIMIT 1) sub
            )
GROUP BY 1, 2
ORDER BY 3 desc

/* ¿Cuál es el monto promedio de por vida gastado en términos de 'total_amt_usd' para las 10 principales 
cuentas de gasto total?
- Primero, solo queremos encontrar las 10 cuentas principales en términos de 'total_amt_usd' más alto.
- Ahora, solo queremos el promedio de estas 10 cantidades.*/

SELECT AVG(suma) FROM (
      SELECT a.id, a.name, SUM(o.total_amt_usd) AS suma
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY suma DESC
      LIMIT 10
         ) sub


/* ¿Cuál es el monto promedio de por vida gastado en términos de 'total_amt_usd', incluidas solo las 
empresas que gastaron más por pedido, en promedio, que el promedio de todos los pedidos?
- Primero, queremos sacar el promedio de todas las cuentas en términos de 'total_amt_usd':
- Entonces, solo queremos extraer las cuentas con más de esta cantidad promedio.
- Finalmente, solo queremos el promedio de estos valores.*/

SELECT AVG(media) FROM (
SELECT o.account_id AS nombre, AVG(o.total_amt_usd) media
FROM orders o
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) AS promedio
	FROM orders o)) sub