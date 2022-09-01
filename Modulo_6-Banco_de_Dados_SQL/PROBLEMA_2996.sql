	-- PROBLEMA 2996

select 
	packages.year, 
	sender.name as sender, 
	receiver.name as receiver
from packages 
join users as sender
     on packages.id_user_sender = sender.id 
join users as receiver
     on packages.id_user_receiver = receiver.id
where (packages.year = 2015 or packages.color = 'blue')
     AND receiver.address <> 'Taiwan' 
order by packages.year desc;