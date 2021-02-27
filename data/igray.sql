/*select name, cast(price as money), rating, cast(review_count as int), content_rating, primary_genre
from app_store_apps
union all
select name, cast(price as money), rating, review_count, content_rating, genres
from play_store_apps
order by name desc*/

/*SELECT DISTINCT(UPPER(a.name)),a.price,a.review_count,a.rating,a.content_rating,a.primary_genre, p.category, p.rating, p.review_count, p.size, p.install_count, p.type, p.price, p.content_rating, p.genres
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON UPPER(a.name) = UPPER(p.name)*/

--Highest Rated with Install Base > 1 Million
/*select distinct(lower(p.name)), cast(a.price as float), a.rating, p.rating, 
			a.content_rating, cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.content_rating, p.genres
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and cast(replace(replace(install_count, '+', ''), ',', '') as float) >= 1000000000
order by p.rating desc, in_co desc*/

/*SELECT name, rating1,rating2,
	ROUND((-10000 * price1) + (5000 * (rating1/.125)) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	ROUND((-10000 * price1) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
FROM
	(SELECT DISTINCT(UPPER(a.name)) AS name, CAST(a.price AS NUMERIC(10,2))AS price1, a.rating AS rating1, a.content_rating AS c_rating1, a.primary_genre AS genre1, 
									p.price AS price2, p.rating AS rating2, p.content_rating AS c_rating2, p.genres AS genre2
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
ORDER BY net_income_by_rating DESC
*/

/* with install base*/
/*select distinct(lower(p.name)), cast(a.price as float), a.rating, p.rating, 
			 cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, cast(REPLACE(a.content_rating,'+','') as float)as age, p.genres
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 /*and cast(replace(replace(install_count, '+', ''), ',', '') as float) >= 500000000*/
order by a.rating desc/*, in_co desc*/*/

/*count of titles by age rating*/
/*select count(distinct(lower(p.name))), cast(REPLACE(a.content_rating,'+','') as float)as age/*, cast(a.price as float), a.rating, p.rating, 
			 cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.genres*/
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and a.rating >= 4.5
group by age*/

/*select count(distinct(lower(p.name))) as title_count, cast(REPLACE(a.content_rating,'+','') as float)as age_group, p.genres/*, cast(a.price as float), a.rating, p.rating, 
			 cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.genres*/
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and a.rating >= 4.5
group by genres, age_group
order by title_count desc, age_group desc*/

/*select count(distinct(lower(p.name))) as title_count, ROUND(SUM(CASE WHEN price <= 1 THEN 10000 END)) + (5000 * (rating1/.125) + (-1000*(rating1/.125)),2) AS Net_income_by_rating,
	ROUND(SUM(CASE WHEN price < 1 THEN 10000 END)) + (5000 * (rating2/.125)) + (-1000*(rating2/.125)),2) AS Net_income_by_rating2
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and a.rating >= 4.5
group by genres
order by title_count desc*/

/*;WITH sums AS 
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
   sums*/

SELECT 
		app, apple_price, google_price, apple_rating, new_google_rating, age, in_co, google_content_rating, apple_genre, google_genre,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (new_google_rating/.125)) + (-1000*(new_google_rating/.125)),2) AS net_income_by_google_rating,
		(ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + 
			  					(-1000*(apple_rating/.125)),2) + ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (new_google_rating/.125)) + 
			  					(-1000*(new_google_rating/.125)),2))/2 
							as avg_income
FROM
	(SELECT 
	 		DISTINCT(UPPER(a.name)) AS app, 
	 		CAST(a.price AS NUMERIC(10,2))AS apple_price, CAST(REPLACE(p.price,'$','') AS NUMERIC(10,2)) AS google_price,
	 		a.rating AS apple_rating, ceiling(cast(p.rating as numeric)/.5)* .5 as new_google_rating, cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co,
	 		cast(REPLACE(a.content_rating,'+','') as float)as age, p.content_rating AS google_content_rating,
			a.primary_genre AS apple_genre, p.genres AS google_genre	 		
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	ON UPPER(a.name) = UPPER(p.name)) AS combo
where apple_price = 0 and google_price = 0
ORDER BY avg_income DESC, in_co desc

SELECT
		names_of_apps, apple_price, google_price, apple_rating, google_rating, apple_content_rating, google_content_rating, apple_genre, google_genre, google_install_count,
		ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2) AS net_income_by_apple_rating,
		ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
			  				 WHEN google_price >1 THEN google_price END )+ (5000 * (google_rating/.125)) + (-1000*(google_rating/.125)),2) AS net_income_by_google_rating,
		(ROUND((-10000 * CASE WHEN apple_price <=1 THEN 1
			  				 WHEN apple_price >1 THEN apple_price END )+ (5000 * (apple_rating/.125)) + (-1000*(apple_rating/.125)),2)
	  		+ ROUND((-10000 * CASE WHEN google_price <=1 THEN 1
								   WHEN google_price >1 THEN google_price END )+ (5000 * (google_rating/.125)) + (-1000*(google_rating/.125)),2))/2  AS avg_net_income	
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
ORDER BY avg_net_income DESC, google_install_count DESC, names_of_apps	