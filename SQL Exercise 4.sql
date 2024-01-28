create database bootcamp_exercise4;

use bootcamp_exercise4;

create table players (
	player_id integer not null unique,
    group_id integer not null
);

create table matches (
	match_id integer not null unique,
    first_player integer not null,
    second_player integer not null,
    first_score integer not null,
    second_score integer not null
);

truncate players;

insert into players (player_id, group_id) values 
(20,2),
(30,1),
(40,3),
(45,1),
(50,2),
(65,1);

insert into matches (match_id, first_player, second_player, first_score, second_score) values
(1,30,45,10,12),
(2,20,50,5,5),
(13,65,45,10,10),
(5,30,65,3,15),
(42,45,65,8,4);

with scores as (
select p.player_id, m.first_score as score, p.group_id
from players p
left join matches m on p.player_id = m.first_player
union all
select p.player_id, m.second_score as score, p.group_id
from players p
left join matches m on p.player_id = m.second_player
), scores2 as (
	select s.player_id, sum(s.score) as score,s.group_id
	from scores s
    group by s.player_id, s.group_id
), gp_max_score as (
	select s2.group_id, max(s2.score) as score
	from scores2 s2
	group by s2.group_id
)

select gms.group_id, min(s2.player_id)
from gp_max_score gms
left join scores2 s2 on (gms.score = s2.score and gms.group_id = s2.group_id)
or (gms.group_id = s2.group_id and s2.score is null and gms.score is null)
group by gms.group_id
order by gms.group_id
;



