	-- PROBLEMA 2606

select
    a.id,
    a.name
from products as a
inner join categories as b
	on a.id_categories = b.id
where lower(b.name) like 'super%';