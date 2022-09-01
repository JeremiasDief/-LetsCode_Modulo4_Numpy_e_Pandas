	-- PROBLEMA 2994

select
	name,
	round(sum((150 * horas_somadas) * (1 + (bonus/100))), 1) as salary
from
	(select
		doctors.name,
		sum(attendances.hours) as horas_somadas,
		work_shifts.bonus
	from doctors
	full join attendances
		on doctors.id = attendances.id_doctor
	full join work_shifts
		on attendances.id_work_shift = work_shifts.id
	group by doctors.id, work_shifts.bonus
	order by doctors.id) as work_hours_and_bonus
group by name
order by salary desc;