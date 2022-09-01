	-- PROBLEMA 2740

(select
    concat('Podium: ', team) as name
from league
limit 3)

union all

(select
    concat('Demoted: ', team) as name
from league
where position in (14, 15));