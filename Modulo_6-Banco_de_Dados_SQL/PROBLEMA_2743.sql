	-- PROBLEMA 2743

select
    name,
    length(name) as length
from people
order by length desc;