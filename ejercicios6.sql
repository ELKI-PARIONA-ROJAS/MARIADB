-- Necesita encontrar el número promedio de eventos para cada canal por día.
SELECT CHANNEL, avg(eventos)
FROM (SELECT DAY(occurred_ad) DAY, CHANNEL, COUNT(*) eventos
		FROM web_events 
		GROUP BY 1, 2) sub
GROUP BY CHANNEL 
ORDER BY 2 DESC

-- Intentemos esto de nuevo usando una declaración CON.
-- Aviso, puede extraer la consulta interna:
WITH eventitos AS ( SELECT DAY(occurred_ad) DAY, CHANNEL, COUNT(*) eventos
		FROM web_events 
		GROUP BY 1, 2)
		
SELECT CHANNEL, AVG(eventos) AS promedio
FROM eventitos
GROUP BY CHANNEL
ORDER BY 2 desc


/* Para el ejemplo anterior, no necesitamos más que una tabla adicional, pero imagina que necesitamos 
crear una segunda tabla para extraer. Podemos crear una tabla adicional para extraer de la siguiente manera:*/

WITH TABLE1 AS( SELECT * FROM web_events),
	  TABLE2 AS( SELECT * FROM orders )
SELECT * 
FROM TABLE1 t1
JOIN TABLE2 t2
ON t1.account_id = t2.account_id