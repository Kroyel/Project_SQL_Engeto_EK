# Project_SQL_Engeto_EK
Development of the Engeto Data Academy project.

Tento project zpracovává výzkumné otázky, které se týkají především mezd v různých odvětvích a rozdílů v cenách v potravin, dále pak vlivu HDP států na mzdy. Cílem bylo vytvořit datové podklady z dostupných zdrojů, pomocí kterých lze následně odpovědět na výzkumné otázky. 


##Vytvořené tabulky


Tabulka 1 - Tabulka s informacemi o průměrných mzdách a průměrných cenách potravin za zkoumané období.

K tabulce "Czechia_payroll" jsou připojeny vedlejší tabulky, které slouží k popisu hodnot ve sloupcích. Dále je připojena tabulka cen "Czechia_price" ke každé průměrné mzdě, což umožňuje porovnání. Z tabulky mezd byly vybrány pouze údaje o mzdách. Ceny jsou zprůměrovány z hodnot za celou republiku. Z tabulky cen jsou připojeny následující informace, a to: název položky, rok ceny, průměrná cena. Propojení mezi tabulkou mezd a cen je realizováno přes rok sběru dat. Ve výsledné tabulce jsou uvedeny následující údaje: ID zaměstnavatele, hodnota mzdy, jednotka mzdy, pojmenování průměrné hrubé mzdy, údaj o druhu mzdy, odvětví, rok odečtu, jméno produktu a průměrná cena v daném roce.


Tabulka 2 - Tabulka s dodatečnými daty o dalších Evropských státech.
Na tabulku "economies" je napojena tabulka "countries". Jméno země z tabulky "economies" je odstraněno, a populace je přejmenována na "population_in_year".


##Výzkumné otázky


1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

Ne, mzdy v některých odvětvích v průběhu let klesají. Z tabulky se dá vyčíst, ve kterém roce a odvětví došlo k poklesu průměrné roční mzdy oproti předchozímu roku. Jde o celkem 23 případů napříč odvětvími a roky. Nejčastější pokles byl v odvětví Těžby o dobývání, kdy byl zaznamenán pokles mzdy v letech 2009, 2013, 2014 a 2016.


2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

V roce 2006 bylo možné koupit 1 287 kg chleba a 1 437 litrů mléka. V roce 2018 bylo možné koupit 1 342 kg chleba a 1 641 litrů mléka.


3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

Zde jsou připraveny dva scripty pro zobrazení oblasti poklesu cen a růstu cen. Z první tabulky lze zjistit, o kolik procent se snížila cena komodity nejvíce oproti předchozímu roku. V roce 2007 se Rajská jablka červená kulatá prodávala za 69,72 % ceny z roku 2006, což byl také největší pokles ceny ze všech vybraných kategorií potravin. Po spuštění druhého scriptu lze zjistit nejnižší nárůst ceny, který byl v roce 2009 u kategorie Rostlinný roztíratelný tuk.


4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

Nejprve je vypočítán nárůst cen potravin pro každý rok a tento nárůst je zprůměrován. Dále je porovnán nárůst platu v každém odvětví s průměrným růstem cen potravin. Výsledná tabulka zobrazuje roky a odvětví, ve kterých ceny vzrostly výrazně více než mzdy (10 % a více). Konkrétně jde o roky 2008, 2010, 2011, 2013, 2017 a 2018.


5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

Připravený script zobrazí údaje o HDP pro Českou republiku společně s údaji o vývoji cen a mezd. V tabulce jsou zohledněny pouze roky, kde jsou dostupné hodnoty všech sloupců. Z tabulky je zřejmé, že změna výše HDP nemá prokazatelný vliv na změny ve mzdách a cenách potravin.

