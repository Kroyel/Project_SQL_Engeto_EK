-- otázka č. 2
-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	year_table,
	round(avg(value)),
	name,
	avg_price,
	round((avg(value)) / avg_price,2) as quantity
FROM t_eliska_kroyova_project_sql_primary_final tekpspf 
WHERE (name = 'Mléko polotučné pasterované' OR name = 'Chléb konzumní kmínový') AND (year_table = (
	SELECT min(year_table) FROM t_eliska_kroyova_project_sql_primary_final tekpspf2) OR year_table = (
	SELECT max(year_table) FROM t_eliska_kroyova_project_sql_primary_final tekpspf3))
GROUP BY year_table, name 
ORDER BY quantity DESC;


