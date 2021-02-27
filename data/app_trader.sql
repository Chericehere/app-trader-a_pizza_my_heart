--Both Tables, ratings, income
SELECT name, rating1, rating2,
	ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	ROUND((-10000 * price1) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									p.price AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
ORDER BY net_income_by_rating DESC


SELECT name, SUM(10000 * CASE WHEN price <= 1 THEN 10000 END)
FROM app_store_apps
group by NAME


--Count overlap between the 2 datasets
select sum((case when name in (select name from play_store_apps) then 1 else 0 end)) as overlap_ct, count(*) as apple_ct
from app_store_apps


--App name and price comparison between stores
select a.name, a.price as apple_price, p.price AS google_price
FROM app_store_apps a,
	play_store_apps p
where a.name = p.name 

--Cost of purchasing app App$*10000
SELECT a.name, a.price AS apple_price, SUM(a.price*10000) AS app_purchase_cost, p.price AS google_price, SUM(CAST(p.price AS int)*10000) AS play_purchase_cost
FROM app_store_apps a,
	play_store_apps p
where a.name = p.name 


--Brenda's Query
SELECT 
		app, apple_price, google_price, apple_rating, google_rating, apple_content_rating, google_content_rating, apple_genre, google_genre, 
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (google_rating/.125)) + (-1000*(google_rating/.125)),2) AS net_income_by_google_rating
FROM
	(SELECT 
	 		DISTINCT(UPPER(a.name)) AS app, 
	 		CAST(a.price AS NUMERIC(10,2))AS apple_price, CAST(REPLACE(p.price,'$','') AS NUMERIC(10,2)) AS google_price,
	 		a.rating AS apple_rating, p.rating AS google_rating, 
	 		a.content_rating  AS apple_content_rating, p.content_rating AS google_content_rating,
			a.primary_genre AS apple_genre, p.genres AS google_genre	
	 		
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
	ORDER BY net_income_by_apple_rating DESC, net_income_by_google_rating  DESC 



--Brend'a Query Recoded
SELECT
		names_of_apps, apple_price, google_price, apple_rating, google_rating, apple_content_rating, google_content_rating, apple_genre, google_genre, google_install_count,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (google_rating/.125)) + (-1000*(google_rating/.125)),2) AS net_income_by_google_rating,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2)
	  		+ ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
								   WHEN google_price >1 THEN google_price END )+ (5000 * (google_rating/.125)) + (-1000*(google_rating/.125)),2)  AS total_net_income	
FROM
	(SELECT
	 		DISTINCT(UPPER(a.name)) AS names_of_apps,
	 		CAST(a.price AS NUMERIC(10,2))AS apple_price, CAST(REPLACE(p.price,'$','') AS NUMERIC(10,2)) AS google_price,
	 		a.rating AS apple_rating, ceiling(cast(p.rating as NUMERIC)/.5)* .5 as google_rating,
	 		a.content_rating  AS apple_content_rating, p.content_rating AS google_content_rating,
	 		a.primary_genre AS apple_genre, p.genres AS google_genre,
	 										CAST (REPLACE(REPLACE(p.install_count,'+',''),',','')AS INT) AS google_install_count
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
ORDER BY total_net_income DESC, names_of_apps
LIMIT 10
