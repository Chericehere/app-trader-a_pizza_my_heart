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

select distinct(lower(p.name)), cast(a.price as float), a.rating, p.rating, 
			a.content_rating, cast(replace(replace(install_count, '+', ''), ',', '') as float) as in_co, 
			p.type, p.price, p.content_rating, p.genres
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
where cast(a.price as float) <= 1.00 and cast(replace(replace(install_count, '+', ''), ',', '') as float) >= 500000000
order by p.rating desc, in_co desc