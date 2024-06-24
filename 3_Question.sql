-- otázka č. 3
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?


-- pro zjištění poklesu
SELECT 
	com_year,
	name,
	min_price_percente
FROM 
	(SELECT 
		price_tab.year_table_2 AS com_year,
		name,	
		price_tab.grad AS min_price_percente,
		RANK() OVER(PARTITION BY com_year ORDER BY min_price_percente ASC) ranking
	FROM 
		(SELECT 
			tab1.year_table,
			tab2.year_table AS year_table_2,
			tab1.name,
			tab1.avg_price AS price1,
			tab2.avg_price AS price2,
			round(tab2.avg_price/tab1.avg_price * 100, 2) AS grad
		FROM (SELECT year_table, name, avg_price 
			FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
			GROUP BY year_table, name) tab1	
		JOIN (SELECT year_table, name, avg_price 
			FROM t_eliska_kroyova_project_sql_primary_final tekpspf2 
			GROUP BY year_table, name) tab2
			ON tab1.year_table + 1 = tab2.year_table
			AND tab1.name = tab2.name
		GROUP BY tab1.year_table, name) price_tab
	GROUP BY com_year, name) tz
WHERE ranking = 1;


-- pro zjištění zdražování 
SELECT 
	com_year,
	name,
	min_price_percente*100-100 AS inc_precent
FROM (SELECT 
		price_tab.year_table_2 AS com_year,
		name,	
		price_tab.grad AS min_price_percente,
		RANK() OVER(PARTITION BY com_year ORDER BY min_price_percente ASC) ranking
	FROM 
		(SELECT 
			tab1.year_table,
			tab2.year_table AS year_table_2,
			tab1.name,
			tab1.avg_price AS price1,
			tab2.avg_price AS price2,
			tab2.avg_price/tab1.avg_price AS grad
		FROM (SELECT year_table, name, avg_price 
			FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
			GROUP BY year_table, name) tab1	
		JOIN (SELECT year_table, name, avg_price 
			FROM t_eliska_kroyova_project_sql_primary_final tekpspf2 
			GROUP BY year_table, name) tab2
			ON tab1.year_table + 1 = tab2.year_table
			AND tab1.name = tab2.name
		GROUP BY tab1.year_table, name) price_tab
		WHERE price_tab.grad >= 1 
	GROUP BY com_year, name) tz
WHERE ranking = 1;


