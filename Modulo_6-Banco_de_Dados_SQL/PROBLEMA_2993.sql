	-- PROBLEMA 2993

select
    count(amount) as most_frequent_value
from value_table
group by amount
order by amount desc
limit 1;