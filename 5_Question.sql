-- Otázka č. 5
-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

SELECT 
	tekpssf.country,
	tekpssf.`year`,
	round(tekpssf.GDP/tekpssf2.GDP*100-100,2) AS inc_HDP,
	food_tab.inc_price_food,
	wage_tab.inc_wage
FROM t_eliska_kroyova_project_sql_secondary_final tekpssf 
JOIN (SELECT 
		country,
		`year`,
		GDP 
	FROM t_eliska_kroyova_project_sql_secondary_final tekpssf2 
	WHERE country = ('Czech Republic')) tekpssf2
	ON tekpssf.`year` = tekpssf2.`year`+1
JOIN (
	SELECT 
		tekpspf.year_table,
		tekpspf.name,
		round(sum(tekpspf.avg_price)/next_year.suma*100-100,2) AS inc_price_food
	FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
	JOIN (SELECT 
			year_table,
			name,
			sum(avg_price) AS suma  
		FROM t_eliska_kroyova_project_sql_primary_final tekpspf2 
		GROUP BY year_table) next_year
		ON tekpspf.year_table = next_year.year_table + 1
	GROUP BY tekpspf.year_table) food_tab
	ON tekpssf.`year` = food_tab.year_table
JOIN (
	SELECT 
		tekpspf.year_table,
		tekpspf.name,
		round(sum(tekpspf.value)/next_year.suma*100-100,2) AS inc_wage
	FROM t_eliska_kroyova_project_sql_primary_final tekpspf
	JOIN (SELECT 
			year_table,
			name_industry_branch,
			sum(value) AS suma  
		FROM t_eliska_kroyova_project_sql_primary_final tekpspf
		GROUP BY year_table) next_year
		ON tekpspf.year_table = next_year.year_table + 1
	GROUP BY tekpspf.year_table) wage_tab
	ON tekpssf.`year` = wage_tab.year_table
WHERE tekpssf.country = ('Czech Republic')
ORDER BY `year`;

