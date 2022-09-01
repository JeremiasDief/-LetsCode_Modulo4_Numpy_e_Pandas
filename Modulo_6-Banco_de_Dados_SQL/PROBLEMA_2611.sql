	-- PROBLEMA 2611

select
	a.id,
	a.name
from movies as a
inner join genres as b
	on a.id_genres = b.id
where b.description = 'Action';