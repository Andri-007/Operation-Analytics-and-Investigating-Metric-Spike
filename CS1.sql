create database project3;
show databases;
use project3;
create table job_data
(ds DATE,
job_id INT NOT NULL,
actor_id INT NOT NULL,
event VARCHAR(15) NOT NULL,
language VARCHAR(15) NOT NULL,
time_spent INT NOT NULL,
org char(2)
);


INSERT INTO job_data (ds,job_id,actor_id,event,language,time_spent,org)
VALUES ('2020-11-30',21,1001,'skip','english',15,'A'),
('2020-11-30',22,1006,'transfer','Arabic',25,'B'),
('2020-11-29',23,1003,'decision','Persian',20,'C'),
('2020-11-28',23,1005,'transfer','Persian',22,'D'),
('2020-11-28',25,1002,'decision','Hindi',11,'B'),
('2020-11-27',11,1007,'decision','French',104,'D'),
('2020-11-26',23,1004,'skip','Persian',56,'A'),
('2020-11-25',20,1003,'transfer','Italian',45,'C');

select * from job_data;


#Task1
select avg(s) as 'average number of jobs reviewed per hour per day'
from
(select 
ds, 
count(job_id)*3600/sum(time_spent) as s
from job_data
where month(ds)=11
group by ds)a;

#Task2
select ROUND(COUNT(event)/SUM(time_spent),2) as 'weekly throughput' from job_data;

select ds as Dates, ROUND(COUNT(event)/SUM(time_spent),2) as 'Daily throughput' from job_data
group by ds order by ds;

#Task3
select language as Languages, ROUND(100*COUNT(*)/total,2) AS Percentage, sub.total
from job_data
cross join (select count(*) as total from job_data) as sub
group by language, sub.total;

#Task4
select actor_id, count(*) as duplicates from job_data
group by actor_id having count(*)>1;



