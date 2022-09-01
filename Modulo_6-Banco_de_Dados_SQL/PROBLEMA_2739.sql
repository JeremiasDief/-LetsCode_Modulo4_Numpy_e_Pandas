	-- PROBLEMA 2739

select
    name,
    cast(extract(day from payday) as int) as day
from loan;