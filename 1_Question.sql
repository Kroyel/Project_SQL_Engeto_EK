-- otázka č. 1	
-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT 
	all_table.year_compare,
	all_table.value_prev,
	all_table.value_compare,
	all_table.name_industry_branch
FROM 
	(SELECT 
		tekpspf.year_table AS year_prev,
		tekpspf2.year2 AS year_compare,
		round(avg(tekpspf.value)) AS value_prev,
		round(avg(tekpspf2.value)) AS value_compare,
		tekpspf.name_industry_branch,
		CASE 
			WHEN round(avg(tekpspf2.value)) > round(avg(tekpspf.value)) THEN 1
			ELSE 0
		END AS 'compare_wage'
	FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
	JOIN (
		SELECT 
			year_table AS year2,
			round(avg(value)) AS value,
			name_industry_branch
		FROM t_eliska_kroyova_project_sql_primary_final tekpspf2  
		GROUP BY year_table, name_industry_branch 
		-- ORDER BY name_industry_branch, year_table 
		) tekpspf2 
		ON tekpspf.name_industry_branch = tekpspf2.name_industry_branch
		AND tekpspf.year_table + 1 = tekpspf2.year2
	GROUP BY year_table, name_industry_branch 
	ORDER BY name_industry_branch, year_table) all_table
WHERE all_table.compare_wage = 0;
