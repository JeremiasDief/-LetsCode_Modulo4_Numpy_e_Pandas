	-- PROBLEMA 2744

select
    id,
    password,
    md5(password)
from account;