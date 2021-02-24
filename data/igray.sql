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


select distinct(lower(a.name)), a.price, a.rating,a.content_rating,a.primary_genre, p.category, p.rating, p.size, p.install_count, p.type, p.price, p.content_rating, p.genres
from app_store_apps as a
inner join play_store_apps as p
on lower(a.name) = lower(p.name)
order by lower(a.name) desc