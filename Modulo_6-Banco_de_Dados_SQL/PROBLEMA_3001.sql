	-- PROBLEMA 3001

select
    products.name as type,
    case
        WHEN products.type = 'A' then 20.0
        WHEN products.type = 'B' then 70.0
        WHEN products.type = 'C' then 530.5
    end as price
from products
order by products.type, products.id desc;