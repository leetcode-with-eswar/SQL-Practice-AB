
create DATABASE if not exists  SQL3; 

use SQL3;

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

SELECT * from entries;


-- ========================================================================
with t1 as ( select 
                name, 
                floor as most_visited, 
                rank() over(order by count(*) desc) as rnk
            FROM
                entries
            GROUP BY name, floor 
), t2 as (
        SELECT
            name, count(*) as total_visits,  GROUP_CONCAT(distinct resources) as resources_used
        FROM
            entries
        GROUP BY name 
)
SELECT
    t1.name, total_visits, most_visited, resources_used
FROM
    t1 JOIN t2 
    ON t1.name = t2.name and rnk = 1;