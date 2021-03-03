/* By calculating which apps would make the greatest net-income we can view their common traits. Apps with these traits 
	TRAIT		APPLE		GOOGLE
	price		free		free
	rating		>4.5		>5.0
	c_rating	+4			Everyone
	genre		Games		-
	in_count	-			Broke ties
				 
*/

SELECT 
		names_of_apps, apple_price, google_price, apple_rating, google_rating, apple_content_rating, google_content_rating, apple_genre, google_genre, google_install_count,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * ((apple_rating/.5+1))*12) + (-1000*((apple_rating/.5+1))*12),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * ((google_rating/.5+1))*12) + (-1000*((google_rating/.5+1))*12),2) AS net_income_by_google_rating,
		(ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * ((apple_rating/.5+1))*12) + (-1000*((apple_rating/.5+1))*12) +
			  (-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * ((google_rating/.5+1))*12) + (-1000*((google_rating/.5+1))*12),2))*.5 AS avg_income				 
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
WHERE apple_price = 0 AND google_price = 0
ORDER BY avg_income DESC, google_install_count DESC, names_of_apps 











