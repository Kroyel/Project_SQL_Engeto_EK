-- tabulka 1
CREATE OR REPLACE TABLE t_Eliska_Kroyova_project_SQL_primary_final AS
	SELECT
		cp.id,
		cp.value,
		cpvt.name AS name_value,
		cpu.name AS name_unit,
		cpc.name AS name_calculation,
		cpib.name AS name_industry_branch,
		cp.payroll_year AS year_table,
		czp.name,
		czp.avg_price
	FROM czechia_payroll cp
	JOIN czechia_payroll_value_type cpvt
		ON cp.value_type_code = cpvt.code
	JOIN czechia_payroll_unit cpu
		ON cp.unit_code = cpu.code
	JOIN czechia_payroll_calculation cpc
		ON cp.calculation_code = cpc.code
	JOIN czechia_payroll_industry_branch cpib
		ON cp.industry_branch_code = cpib.code
	RIGHT JOIN (
		SELECT
			cpc.name, 
			round(avg(cp.value),2) AS avg_price, 
			YEAR(cp.date_from) AS all_year
			FROM czechia_price cp 
			JOIN czechia_price_category cpc 
				ON cp.category_code = cpc.code 
			WHERE cp.region_code IS NULL 
			GROUP BY category_code, YEAR(date_from)
			ORDER BY category_code, date_from
			) czp
		ON cp.payroll_year = czp.all_year
	WHERE cp.value_type_code = 5958;
	


-- tabulka 2
CREATE OR REPLACE TABLE t_Eliska_Kroyova_project_SQL_secondary_final AS 
	SELECT 
		c.*,
		e.`year`,
		e.GDP,
		e.population AS population_in_year,
		e.gini,
		e.taxes,
		e.fertility,
		e.mortaliy_under5
	FROM economies e 
	JOIN countries c 
		ON e.country = c.country
	WHERE c.continent = 'Europe';