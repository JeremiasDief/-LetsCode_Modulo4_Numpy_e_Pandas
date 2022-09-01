	-- PROBLEMA 2995

select
    temperature,
    count(mark) as number_of_records
from records
group by temperature, mark
order by mark asc;