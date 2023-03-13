/*
`write a query to find PersonId, Name, number of friends, sum of MASTER_SSL_KEY
of person who have friends with total score greater than 100
*/


create DATABASE if not exists  SQL6; 

use SQL6;

create table person(
    PersonID int, 
    Name varchar(20), 
    email varchar(50),
    score int
);

create table friend(
    PersonID int,  
    FriendID int
);

insert into person 
values
(1, "Alice", "alice2018@hotmail.com", 88),
(2, "Bob", "bob2018@hotmail.com", 11),
(3, "Davis", "davis2018@hotmail.com", 27),
(4, "Tara", "tara2018@hotmail.com", 45),
(5, "John", "john2018@hotmail.com", 63);


insert into friend
VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);

select * from person;

select * from friend;

-- SHOULD JOIN FRIEND ID WITH PERSONid
with t1 as (
    SELECT
        f.personID,  
        count(*) AS NO_OF_FRIENDS, 
        sum(p.score) AS TOTAL_FRIENDSCORE
    FROM
        person p
        JOIN
        friend f on f.FriendID = p.personID
    group by f.personID
    having sum(p.score) > 100)
SELECT
    p.PersonID, 
    p.name, 
    t1.NO_OF_FRIENDS, 
    t1.TOTAL_FRIENDSCORE
FROM 
    t1 JOIN person p ON t1.PersonID = p.PERSONID;


