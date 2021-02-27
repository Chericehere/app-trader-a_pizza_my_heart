/*SELECT
	DISTINCT (UPPER(a.name)) as name,
	a.price, a.rating, a.primary_genre, p.price, p.rating, p.genres
From app_store_apps AS a
Inner Join play_store_apps as p
ON UPPER(a.name) = UPPER(p.name)
Order by a.rating DESC;*/

/*SELECT DISTINCT(UPPER(a.name)),a.price,a.review_count,a.rating,a.content_rating,a.primary_genre, p.category, p.rating, p.review_count, p.size, p.install_count, p.type, p.price, p.content_rating, p.genres
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON UPPER(a.name) = UPPER(p.name)

SELECT 
	 name, rating1,rating2,genre1,genre2,c_rating1, c_rating2,
	 ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	ROUND((-10000 * price2) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
	
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									CAST(p.price AS NUMERIC(10,2))AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
	Where c_rating1 ilike '%4%'
ORDER BY Net_income_by_rating Desc, net_income_by_rating2 DESC;

SELECT 
	 name, rating1,rating2,genre1,genre2,c_rating1, c_rating2,price1, price2,
	 --Round the cost + the monthly earnings * apps lifespan in months + (-cost to advertise per month)
From SELECT name, SUM(CASE WHEN price < 1 THEN 10000 
				  END)
FROM app_store_apps
group by NAME
ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	 ROUND((-10000 * price2) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
	
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									CAST(p.price AS NUMERIC(10,2))AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
Where genre1 ilike '%game%'
ORDER BY net_income_by_rating DESC;
CTE:
WITH sums AS 
(
   SELECT
      m1, m2, 
      SUM(m1) + SUM(m2) as Total,
      SUM(m1) + SUM(m2) as Total1 
   FROM
      dbo.stud 
   GROUP BY
      m1, m2
)
SELECT 
   m1, m2, 
   total, total1, 
   total+total1 AS 'GrandTotal' 
FROM 
   sums
*/
SELECT 
		app, apple_price, google_price, apple_rating, r_google_rating, apple_content_rating, google_content_rating, apple_genre, google_genre,google_install_count,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (r_google_rating/.125)) + (-1000*(r_google_rating/.125)),2) AS net_income_by_google_rating,
		(ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) + ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (r_google_rating/.125)) + (-1000*(r_google_rating/.125)),2))/2 as avg_net_income


FROM
	(SELECT 
	 		DISTINCT(UPPER(a.name)) AS app, 
	 		CAST(a.price AS NUMERIC(10,2))AS apple_price, 
			--CAST(REPLACE(p.price,'$','') AS NUMERIC(10,2)) AS google_price,
	 		CAST(p.price AS NUMERIC(10,2)) AS google_price,
	 		a.rating AS apple_rating,
			ceiling(cast(p.rating as Numeric)/.5)* .5 as r_google_rating,
			a.content_rating  AS apple_content_rating, 
			p.content_rating AS google_content_rating,
			a.primary_genre AS apple_genre, 
			p.genres AS google_genre,
			CAST (REPLACE(REPLACE(p.install_count,'+',''),',','')AS INT) AS google_install_count
	
 	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)
	) AS combo
Where apple_price=0 and google_price=0
ORDER BY avg_net_income DESC, google_install_count DESC, app;



