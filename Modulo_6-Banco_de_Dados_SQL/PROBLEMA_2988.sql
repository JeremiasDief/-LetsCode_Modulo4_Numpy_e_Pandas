	-- PROBLEMA 2988

select
    teams.name,
    count(matches.team_1 + matches.team_2) as matches,
	SUM(CASE
        WHEN (matches.team_1_goals > matches.team_2_goals
              AND teams.id = matches.team_1)
              OR (matches.team_2_goals > matches.team_1_goals
              AND teams.id = matches.team_2) THEN 1 ELSE 0 END) AS victories,
	sum(case
	    when (matches.team_1_goals < matches.team_2_goals
			  and teams.id = matches.team_1)
			  or (matches.team_2_goals < matches.team_1_goals
			  and teams.id = matches.team_2) then 1 else 0 end) as defeats,
	sum(case
	    when (matches.team_1_goals = matches.team_2_goals
			  and teams.id = matches.team_1)
			  or (matches.team_2_goals = matches.team_1_goals
			  and teams.id = matches.team_2) then 1 else 0 end) as draws,
	SUM(CASE
        WHEN (matches.team_1_goals > matches.team_2_goals
              AND teams.id = matches.team_1)
              OR (matches.team_2_goals > matches.team_1_goals
              AND teams.id = matches.team_2) THEN 3 ELSE 0 END) +
	sum(case
	    when (matches.team_1_goals = matches.team_2_goals
			  and teams.id = matches.team_1)
			  or (matches.team_2_goals = matches.team_1_goals
			  and teams.id = matches.team_2) then 1 else 0 end) as score
from teams
inner join matches
	on teams.id = matches.team_1 or teams.id = matches.team_2
group by teams.name
order by score desc;