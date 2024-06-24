-- otázka č. 4
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT 
	w_year,
	name_industry_branch
FROM (SELECT 
		tekpspf2.year_table AS w_year, 
		tekpspf.name_industry_branch AS name_industry_branch,
		avg_price - round((tekpspf2.value/tekpspf.value *100 - 100),2) AS difference,
		CASE
			WHEN (avg_price - round((tekpspf2.value/tekpspf.value *100 - 100),2))	> 10 THEN 1
			ELSE 0
		END AS more_than_10p
	FROM (SELECT 
			year_table, value, name_industry_branch
		FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
		GROUP BY year_table, name_industry_branch) tekpspf 
	JOIN ( 
		SELECT 
			year_table, value, name_industry_branch
		FROM t_eliska_kroyova_project_sql_primary_final tekpspf2 
		GROUP BY year_table, name_industry_branch) tekpspf2
		ON tekpspf.year_table + 1 = tekpspf2.year_table 
		AND tekpspf.name_industry_branch = tekpspf2.name_industry_branch 
	JOIN (SELECT 
			f_year,
			round(avg(incr_price),2) AS avg_price
		FROM (SELECT 
				tekpspf4.year_table AS f_year, 
				tekpspf3.name,
				round((tekpspf4.avg_price/tekpspf3.avg_price * 100 - 100),2) AS incr_price
			FROM (SELECT 
					year_table,
					name,
					avg_price 
				FROM t_eliska_kroyova_project_sql_primary_final tekpspf3 
				GROUP BY year_table, name) tekpspf3 
			JOIN (SELECT 
					year_table,
					name,
					avg_price 
				FROM t_eliska_kroyova_project_sql_primary_final tekpspf4
				GROUP BY year_table, name) tekpspf4
				ON tekpspf3.year_table + 1 = tekpspf4.year_table 
				AND tekpspf3.name = tekpspf4.name
			WHERE round((tekpspf4.avg_price/tekpspf3.avg_price * 100 - 100),2) > 0
			-- ORDER BY tekpspf3.year_table, tekpspf3.name
			) tab
		WHERE f_year IN (SELECT 
				DISTINCT year_table 
			FROM t_eliska_kroyova_project_sql_primary_final tekpspf5 )
		GROUP BY f_year) apt
		ON tekpspf.year_table + 1 = apt.f_year) fin_tab
WHERE more_than_10p = 1;

