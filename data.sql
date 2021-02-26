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
	 ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	 ROUND((-10000 * price2) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
	
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									CAST(p.price AS NUMERIC(10,2))AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
Where genre1 ilike '%game%'
ORDER BY net_income_by_rating DESC; */