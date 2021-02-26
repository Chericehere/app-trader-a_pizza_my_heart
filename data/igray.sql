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

select count(distinct(lower(p.name))) as title_count, cast(REPLACE(a.content_rating,'+','') as float)as age_group, p.genres/*, cast(a.price as float), a.rating, p.rating, 
			 cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.genres*/
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and a.rating >= 4.5
group by genres, age_group
order by title_count desc, age_group desc

select count(distinct(lower(p.name))) as title_count, /*cast(REPLACE(a.content_rating,'+','') as float)as age_group,*/ p.genres/*, cast(a.price as float), a.rating, p.rating, 
			 cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.genres*/
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and a.rating >= 4.5
group by genres
order by title_count desc

x
