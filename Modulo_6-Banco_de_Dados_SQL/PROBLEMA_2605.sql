	-- PROBLEMA 2605

select
    a.name,
    b.name
from products as a
inner join providers as b
    on a.id_providers = b.id
inner join categories as c
    on a.id_categories = c.id
where c.id = 6;