	-- PROBLEMA 2742

select
    life_registry.name,
    round(life_registry.omega*1.618, 3) as "fator N"
from dimensions
left join life_registry
on dimensions.id = life_registry.dimensions_id
where dimensions.name in ('C875', 'C774') and
    life_registry.name like 'Richard%'
order by life_registry.omega asc;