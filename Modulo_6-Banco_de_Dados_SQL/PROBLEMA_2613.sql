	-- PROBLEMA 2613

select 
    a.id,
    a.name
from movies as a
inner join prices as b
	on a.id_prices = b.id
where b.value < 2;