create DATABASE if not exists  Moulies; 

use Moulies;


create table icc_world_cup
(
    Team_1 VARCHAR(20),
    Team_2 VARCHAR(20),
    Winner VARCHAR(20)
);

Insert into icc_world_cup values('India','SL','India'),
('SL','Aus','Aus'),
('SA','Eng','Eng'),
('Eng','NZ','NZ'),
('Aus','India','India');

select * from icc_world_cup;

-- =================================================================

with t1 as (select 
    team_1 as "team", count(*) as "played",
    sum(case when team_1 = winner then 1
    else 0 
    end )as "won"
FROM
    icc_world_cup
group by team_1),

t2 as (select 
    team_2 as "team", 
    count(*) as "played",
    sum(case when team_2 = winner then 1
    else 0 
    end )as "won"
FROM
    icc_world_cup
group by team_2)

SELECT
    team, sum(played), sum(won), sum(played) - sum(won)
from 
(select * from  t1 union all 
select * from t2) b
-- group by team;
-- select * from t2;
