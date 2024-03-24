show databases;
create database Project3_CS2;
show databases;

use Project3_cs2;

#all excel files in location C:\ProgramData\MySQL\MySQL Server 8.0\Uploads

#Table-1 Users
create table users (
user_id int,
created_At varchar(100),
company_id int,
language varchar(100),
activated_at varchar(100),
state varchar(100));

show variables like 'secure_file_priv';

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
into table users
fields terminated by ","
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from users;
alter table users add column temp_created_at datetime;
update users set temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');
alter table users drop column created_at;
alter table users change column temp_created_at created_At datetime;

#Table-2 events
create table events(
user_id int null,
occured_at varchar(100) null,
event_type varchar(50) null,
event_name varchar(100) null,
location varchar(50) null,
device varchar(50) null,
user_type int null
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv"
into table events
fields terminated by ","
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select * from events;
alter table events add column temp_occured_at datetime;
update events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');
alter table events drop column occured_at;
alter table events change column temp_occured_at occured_At datetime;
alter table events drop column temp_occured_at_at;


#Table-3 email-events
create table email_events
(
user_id int,
occured_at varchar(100),
action varchar(50),
user_type int);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv"
into table email_events
fields terminated by ","
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from email_events;
alter table email_events add column temp_occured_at datetime;
update email_events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');
alter table email_events drop column occured_at;
alter table email_events change column temp_occured_at occured_At datetime;


#case study 2
#task 1
select extract(week from occured_At) as week_number,
count(distinct user_id) as active_user
from events
where event_type='engagement'
group by week_number
order by week_number;

#task2
select year,week_num,num_users,sum(num_users) over(order by year, week_num) as growth_user
from(
select extract(year from activated_at) as year, 
extract(week from activated_at) as week_num, 
count(distinct user_id) as num_users
from project3_cs2.users
where state='active'
group by year,week_num
order by year,week_num)a;

select * from users;

select * from events;
#task3
SELECT 
    DEVICE,
    EXTRACT(YEAR FROM occured_At) AS YEAR,
    EXTRACT(WEEK FROM occured_At) AS WEEK_NUMBER,
    COUNT(DISTINCT USER_ID) user_retention
FROM
    events
WHERE
    EVENT_TYPE = 'ENGAGEMENT'
GROUP BY 1,2,3
ORDER BY 1,2,3;

#task4
SELECT 
	DEVICE,
    EXTRACT(WEEK FROM events.occured_At) AS WEEK_NUM,
    COUNT(DISTINCT USER_ID) AS users
FROM
    events
WHERE
    EVENT_TYPE = 'ENGAGEMENT'
GROUP BY week_num, device
order by device;


#task5
select * from email_events;
SELECT 
    ACTION,
    EXTRACT(MONTH FROM occured_At) AS MONTH,
    COUNT(ACTION) AS NUMBER_OF_MAILS
FROM
    email_events
GROUP BY ACTION , MONTH
ORDER BY ACTION , MONTH; 




