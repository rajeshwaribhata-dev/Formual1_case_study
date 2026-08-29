create table if not exists seasons
(
	year		int primary key,
	url 		varchar(500)
); 


create table if not exists status
(
	statusId	int primary key,	
	status 		varchar(200)
); 


create table if not exists circuits
(
	circuitid		int primary key,
	circuitref		varchar(500),
	name			varchar(500),
	location		varchar(500),
	country			varchar(500),
	latitude		decimal,
	longitude		decimal,
	altitude		int,
	url				varchar(500)
);


create table if not exists races
(
	raceId			int primary key,
	year			int references seasons(year),
	round			int,
	circuitId		int references circuits(circuitid),
	name			varchar(500),
	date			date,
	time			time,
	url				varchar(500),
	fp1_date		date,
	fp1_time		time,
	fp2_date		date,
	fp2_time		time,
	fp3_date		date,
	fp3_time		time,
	quali_date		date,
	quali_time		time,
	sprint_date		date,
	sprint_time		time
); 


create table if not exists drivers
(
	driverId		int primary key,
	driverRef		varchar(500),
	number			int,
	code			varchar(500),
	forename		varchar(500),
	surname			varchar(500),
	dob				date,
	nationality		varchar(500),
	url				varchar(500)
);


create table if not exists constructors
(
	constructorId		int primary key,
	constructorRef		varchar(500),
	name				varchar(500),
	nationality			varchar(500),
	url					varchar(500)
);


create table if not exists constructor_results
(
	constructorResultsId		int primary key,
	raceId						int references races(raceid),
	constructorId				int references constructors(constructorId),
	points						decimal,
	status						varchar(20)
);


create table if not exists constructor_standings
(
	
	constructorStandingsId		int primary key,
	raceId						int references races(raceid),
	constructorId				int references constructors(constructorId),
	points						decimal,
	position					int,
	positionText				varchar(100),
	wins						int
);


create table if not exists driver_standings
(
	
	driverStandingsId		int primary key,
	raceId					int references races(raceid),
	driverId				int references drivers(driverId),
	points					decimal,
	position				int,
	positionText			varchar(100),
	wins					int
);


create table if not exists lap_times
(
	raceId			int references races(raceid),
	driverId		int references drivers(driverId),
	lap				int,
	position		int,
	time			time,
	milliseconds	int
);

create index if not exists idx01_lap_times on lap_times(raceId,driverId);


create table if not exists pit_stops
(
	
	raceId				int references races(raceid),
	driverId			int references drivers(driverId),
	stop				int,
	lap					int,
	time				time,
	duration			interval,
	milliseconds		int
);


create table if not exists qualifying
(
	qualifyId			int primary key,
	raceId				int references races(raceid),
	driverId			int references drivers(driverId),
	constructorId		int references constructors(constructorId),
	number				int,
	position			int,
	q1					time,
	q2					time,
	q3					time
); 



create table if not exists results
(
	
	resultId			int primary key,
	raceId				int references races(raceid),
	driverId			int references drivers(driverId),
	constructorId		int references constructors(constructorId),
	number				int,
	grid				int,
	position			int,
	positionText		varchar(100),
	positionOrder		int,
	points				decimal,
	laps				int,
	time				varchar(30),
	milliseconds		int,
	fastestLap			int,
	rank				int,
	fastestLapTime		time,
	fastestLapSpeed		decimal,
	statusId			int references status(statusId)
); 



create table if not exists sprint_results
(
	resultId			int primary key,
	raceId				int references races(raceid),
	driverId			int references drivers(driverId),
	constructorId		int references constructors(constructorId),
	number				int,
	grid				int,
	position			int,
	positionText		varchar(100),
	positionOrder		int,
	points				decimal,
	laps				int,
	time				varchar(100),
	milliseconds		int,
	fastestLap			int,
	fastestLapTime		time,
	statusId			int references status(statusId)
); 

create or replace procedure pr_validate_count()
language plpgsql
as $$
declare
	v_circuits_org_cnt  INT default 77;
	v_constructors_org_cnt  INT default 211;
	v_drivers_org_cnt  INT default 857;
	v_constructor_results_org_cnt  INT default 12170;
	v_constructor_standings_org_cnt INT default 12941;
	v_driver_standings_org_cnt  INT default 33902;
	v_lap_times_org_cnt  INT default 538121;
	v_pit_stops_org_cnt  INT default 9634;
	v_qualifying_org_cnt  INT default 9575;
	v_races_org_cnt  INT default 1102;
	v_results_org_cnt  INT default 25840;
	v_seasons_org_cnt  INT default 74;
	v_sprint_results_org_cnt  INT default 120;
	v_status_org_cnt  INT default 139;

	v_circuits_cnt  INT;
	v_constructors_cnt  INT;
	v_drivers_cnt  INT;
	v_constructor_results_cnt  INT;
	v_constructor_standings_cnt INT;
	v_driver_standings_cnt  INT;
	v_lap_times_cnt  INT;
	v_pit_stops_cnt  INT;
	v_qualifying_cnt  INT;
	v_races_cnt  INT;
	v_results_cnt  INT;
	v_seasons_cnt  INT;
	v_sprint_results_cnt  INT;
	v_status_cnt  INT;

begin
	select count(1) into v_circuits_cnt from circuits;
	select count(1) into v_constructors_cnt from constructors;
	select count(1) into v_drivers_cnt from drivers;
	select count(1) into v_constructor_results_cnt  from constructor_results; 
	select count(1) into v_constructor_standings_cnt from constructor_standings;
	select count(1) into v_driver_standings_cnt  from driver_standings; 
	select count(1) into v_lap_times_cnt  from lap_times; 
	select count(1) into v_pit_stops_cnt  from pit_stops; 
	select count(1) into v_qualifying_cnt  from qualifying; 
	select count(1) into v_races_cnt  from races; 
	select count(1) into v_results_cnt  from results; 
	select count(1) into v_seasons_cnt  from seasons; 
	select count(1) into v_sprint_results_cnt  from sprint_results; 
	select count(1) into v_status_cnt  from status; 
							
	if v_circuits_cnt 				= v_circuits_org_cnt 				then raise notice 'Circuits table count is Correct!'; 				else raise warning 'Circuits table count MISMATCH!'; end if;
	if v_constructors_cnt 			= v_constructors_org_cnt 			then raise notice 'Constructors table count is Correct!'; 			else raise warning 'Constructors table count MISMATCH!'; end if;
	if v_drivers_cnt 				= v_drivers_org_cnt 				then raise notice 'Drivers table count is Correct!'; 				else raise warning 'Drivers table count MISMATCH!'; end if;
	if v_constructor_results_cnt 	= v_constructor_results_org_cnt 	then raise notice 'Constructor_results table count is Correct!'; 	else raise warning 'Constructor_results table count MISMATCH!'; end if;
	if v_constructor_standings_cnt 	= v_constructor_standings_org_cnt 	then raise notice 'Constructor_standings table count is Correct!'; 	else raise warning 'Constructor_standings table count MISMATCH!'; end if;
	if v_driver_standings_cnt 		= v_driver_standings_org_cnt 		then raise notice 'Driver_standings table count is Correct!'; 		else raise warning 'Driver_standings table count MISMATCH!'; end if;
	if v_lap_times_cnt 				= v_lap_times_org_cnt  				then raise notice 'Lap_times table count is Correct!'; 				else raise warning 'Lap_times table count MISMATCH!'; end if;
	if v_pit_stops_cnt 				= v_pit_stops_org_cnt  				then raise notice 'Pit_stops table count is Correct!'; 				else raise warning 'Pit_stops table count MISMATCH!'; end if;
	if v_qualifying_cnt 			= v_qualifying_org_cnt  			then raise notice 'Qualifying table count is Correct!'; 			else raise warning 'Qualifying table count MISMATCH!'; end if;
	if v_races_cnt 					= v_races_org_cnt  					then raise notice 'Races table count is Correct!'; 					else raise warning 'Races table count MISMATCH!'; end if;
	if v_results_cnt 				= v_results_org_cnt  				then raise notice 'Results table count is Correct!'; 				else raise warning 'Results table count MISMATCH!'; end if;
	if v_seasons_cnt 				= v_seasons_org_cnt  				then raise notice 'Seasons table count is Correct!'; 				else raise warning 'Seasons table count MISMATCH!'; end if;
	if v_sprint_results_cnt 		= v_sprint_results_org_cnt  		then raise notice 'Sprint_results table count is Correct!'; 		else raise warning 'Sprint_results table count MISMATCH!'; end if;
	if v_status_cnt 				= v_status_org_cnt  				then raise notice 'Status table count is Correct!'; 				else raise warning 'Status table count MISMATCH!'; end if;

end;
$$

call pr_validate_count()

select * from seasons; -- 74
select * from status; -- 139	
select * from circuits; -- 77
select * from races; -- 1102
select * from drivers; -- 857
select * from constructors; -- 211
select * from constructor_results; -- 12170
select * from constructor_standings; -- 12941
select * from driver_standings; -- 33902
select * from lap_times; -- 538121
select * from pit_stops; -- 9634
select * from qualifying; -- 9575
select * from results; -- 25840
select * from sprint_results; -- 120

-- 1. Identify the country which has produced the most F1 drivers.
with cte as 
	(select  nationality, count(1), rank() over(order by count(1) desc) rnk from drivers
	group by 1)
select * from cte
where rnk=1

-- 2. Which country has produced the most no of F1 circuits
with cte as 
	(select  country, count(1), rank() over(order by count(1) desc) rnk from circuits
	group by 1)
select country, count from cte
where rnk=1

-- 3. Which countries have produced exactly 5 constructors?
with cte as (select nationality, count(1) cnt from constructors
group by nationality)
select * from cte
where cnt=5

-- 4. List down the no of races that have taken place each year
select year, count(1) from races
group by year
order by 1

-- 5. Who is the youngest and oldest F1 driver?
with cte as 
	(select *, row_number() over (order by dob) as rn, count(*) over() as cnt
	from drivers)
select 
	max(case when rn=1 then forename||' '||surname end) as oldest_driver, 
	max(case when rn=cnt then forename||' '||surname end) as youngest_driver
from cte
where rn = 1 or rn = cnt

-- 6. List down the no of races that have taken place each year and mentioned which was the first and the last race of each season.
select 
	distinct year,
	first_value(name) over(partition by year order by date) as first_race, 
	last_value(name) over(partition by year order by date range between unbounded preceding and unbounded following) as last_race, 
	count(*) over(partition by year) as no_of_races
from races
order by year desc

-- 7. Which circuit has hosted the most no of races. Display the circuit name, no of races, city and country.
with cte as
	(select c.name as circuit_name, count(1) no_of_races, 
	rank() over(order by count(1) desc) as rnk
from races r join circuits c using(circuitid)
group by c.name)
select circuit_name, no_of_races, c.location as city, c.country 
from circuits c
join cte on cte.circuit_name=c.name
where rnk=1;

-- 8. Display the following for 2022 season: 
	-- Year, Race_no, circuit name, driver name, driver race position, driver race points, 
	-- flag to indicate if winner, constructor name, constructor position, constructor points, , flag to indicate if 
	-- constructor is winner 
	-- , race status of each driver, flag to indicate fastest lap for which driver, total no of pit 
	-- stops by each driver

select r.raceid, r.year, r.round as race_no, r.name as circuit_name, concat(d.forename,' ',d.surname) as driver_name, 
ds.position as driver_position, ds.points as driver_points, case when ds.position=1 then 'WINNER' end as winner_flag, 
c.name as constructor_name, cs.position as constructor_position, cs.points as constructor_points, 
case when cs.position=1 then 'WINNER' end as cons_winner_flag, sts.status, 
case when lp.driverid is not null then 'Faster Lap' end as fastest_lap_indi, pt.no_of_stops
from races r
join driver_standings ds on ds.raceid=r.raceid
join drivers d on d.driverid = ds.driverid
join constructor_standings cs on cs.raceid=r.raceid 
join constructors c on c.constructorid=cs.constructorid
join results res on res.raceid=r.raceid and res.driverid=ds.driverid and res.constructorid=cs.constructorid
join status sts on sts.statusid=res.statusid
left join 
	(select lp.raceid, lp.driverid
	from lap_times lp
	join 
		(select raceid, min(time) as fastest_lap
		from lap_times
		group by raceid) x on x.raceid=lp.raceid and x.fastest_lap=lp.time
	) lp on lp.driverid = ds.driverid and lp.raceid=r.raceid
left join 
	(select raceid,driverid, count(1) as no_of_stops
	from pit_stops
	group by raceid,driverid) pt on pt.driverid = ds.driverid and pt.raceid=r.raceid
where year=2022
order by year, race_no, driver_position;
	
-- 9. List down the names of all F1 champions and the no of times they have won it.
with cte as 
		(select r.year, concat(d.forename,' ',d.surname) as driver_name, 
		sum(res.points) as tot_points, 
		rank() over(partition by r.year order by sum(res.points) desc) as rnk
		from races r
		join driver_standings ds on ds.raceid=r.raceid
		join drivers d on d.driverid=ds.driverid
		join results res on res.raceid=r.raceid and res.driverid=ds.driverid  
		group by r.year,  res.driverid, concat(d.forename,' ',d.surname) ),
	cte_rnk as
		(select * from cte where rnk=1)
select driver_name, count(1) as no_of_championships
from cte_rnk
group by driver_name
order by 2 desc;

-- 10. Who has won the most constructor championships
with cte as (select  r.year as year, constructorref constructor, sum(points) points, rank() over(partition by r.year order by sum(points) desc) rnk from constructor_results cr join races r using(raceid) join constructors con using(constructorid) 
group by 1,2)
select year, constructor, points from cte
where rnk=1
order by 1

-- 11. How many races has India hosted?
select count(*) from circuits join races using(circuitid) 
where country ilike 'india'

-- 12. Identify the driver who won the championship or was a runner-up. Also display the team they belonged to.
with cte as 
			(select r.year, concat(d.forename,' ',d.surname) as driver_name, 
				c.name as constructor_name, sum(res.points) as tot_points, 
				rank() over(partition by r.year order by sum(res.points) desc) as rnk
			from races r
			join driver_standings ds using(raceid)
			join drivers d using(driverid)
			join results res on res.raceid=r.raceid and res.driverid=ds.driverid 
		    join constructors c using(constructorid) 
			group by r.year,  res.driverid, concat(d.forename,' ',d.surname), c.name)
	select year, driver_name, case when rnk=1 then 'Winner' else 'Runner-up' end as flag 
	from cte 
	where rnk<=2;

-- 13. Display the top 10 drivers with most wins.
with cte as (select ds.driverid, concat(d.forename,' ',d.surname) as driver_name, 
		count(1) as race_wins, 
		rank() over(order by count(1) desc) as rnk
		from driver_standings ds
		join drivers d on ds.driverid=d.driverid
		where position=1
		group by ds.driverid, concat(d.forename,' ',d.surname)
		order by race_wins desc, driver_name
)
select driver_name, race_wins
	from cte
	where rnk <= 10;

-- 14. Display the top 3 constructors of all time.
with cte as 
	(select
	c.constructorref name, sum(cs.wins) wins,  row_number() over(order by sum(cs.wins) desc) rnk
	from constructor_standings cs join constructors c using(constructorid)
	group by 1)
select name, wins, rnk from cte
where rnk<=3

-- 15. Identify the drivers who have won races with multiple teams.
with cte as (select distinct r.driverid, 
		concat(d.forename,' ',d.surname) as driver_name, 
		c.name as constructor_name
		from results r
		join drivers d on d.driverid=r.driverid
		join constructors c on c.constructorid=r.constructorid
		where r.position=1)

select driver_name, string_agg(constructor_name,', ')
	from cte
	group by 1
	having count(1) > 1
	order by 1;

-- 16. How many drivers have never won any race.
select d.driverref from results r join drivers d on d.driverid=r.driverid
where position<>1
group by 1

-- 17. Are there any constructors who never scored a point? if so mention their name and how many races they participated in?
select cs.constructorid, c.name as constructor_name, 
	sum(cs.points) as total_points, 
	count(1) as no_of_races
from constructor_results cs
join constructors c on c.constructorid=cs.constructorid
group by cs.constructorid, c.name
having sum(cs.points) = 0
order by no_of_races desc, constructor_name ;

-- 18. Mention the drivers who have won more than 50 races.
select concat(d.forename,' ',d.surname) as driver_name, 
	count(1) as race_wins
from driver_standings ds
join drivers d on ds.driverid=d.driverid
where position=1
group by concat(d.forename,' ',d.surname)
having count(1) > 50
order by race_wins desc, driver_name;

-- 19. Identify the podium finishers of each race in 2022 season
select r.name as race, 
	concat(d.forename,' ',d.surname) as driver_name, 
	ds.position
from driver_standings ds 
join races r on r.raceid=ds.raceid
join drivers d on d.driverid=ds.driverid
where r.year = 2022
and ds.position <= 3
order by r.raceid;

-- 20. For 2022 season, mention the points structure for each position. i.e. how many points are awarded to each race finished position.
with cte as 
	(select min(res.raceid) as raceid
	from races r
	join results res using(raceid)
	where year=2022)
select r.position, r.points
from results r
join cte using(raceid)
where r.points > 0;


-- 21. How many drivers participated in 2022 season?
select count(distinct driverid) as no_of_drivers_in_2022
	from driver_standings
	where raceid in (select raceid from races r where year=2022);

-- 22. How many races has the top 5 constructors won in the last 10 years.
with cons as 
	(select cs.constructorid, c.name as constructor_name, count(1) as race_wins, 
	rank() over(order by count(1) desc) as rnk
	from constructor_standings cs
	join constructors c on c.constructorid=cs.constructorid
	where position = 1
	group by cs.constructorid, c.name
	order by race_wins desc), 
top_5_teams as
	(select constructorid, constructor_name from cons
	where rnk <= 5),
cs as 
	(select cs.constructorid, count(1) as wins
	from constructor_standings cs 
	join races r on r.raceid=cs.raceid
	where cs.position = 1
	and r.year >= (extract(year from current_date) - 10)
	group by cs.constructorid)

select cte.constructorid, cte.constructor_name, coalesce(cs.wins,0) as wins
from top_5_teams cte 
left join cs using(constructorid)
order by wins desc;


-- 23. Display the winners of every sprint so far in F1
select r.year, r.name, concat(d.forename,' ',d.surname) as driver_name
from sprint_results sr
join drivers d using(driverid)
join races r using(raceid)
where sr.position=1
order by 1,2;

-- 24. Find the driver who has the most no of Did Not Qualify during the race.
with cte as 
	(select r.driverid, concat(d.forename,' ',d.surname) as driver_name, 
		count(1) as cnt, rank() over(order by count(1) desc) as rnk
	from status s
	join results r using(statusid)
	join drivers d using(driverid)
	where s.status='Did not qualify'
	group by 1,2
	order by cnt desc)
select driver_name, cnt
from cte
where rnk=1;

-- 25. During the last race of 2022 season, identify the drivers who did not finish the race and the reason for it.
select concat(d.forename,' ',d.surname) as driver_name, s.status
from results r
join status s using(statusid)
join drivers d using(driverid)
where r.raceid = (select max(raceid) from races where year=2022)
and r.statusid<>1;

-- 26. What is the average lap time for each F1 circuit. Sort based on least lap time.
select cr.circuitid, cr.name as circuit_name, cr.location, cr.country, avg(lt.time) as avg_lap_time
from circuits cr
left join races r on cr.circuitid=r.circuitid
left join lap_times lt on r.raceid=lt.raceid
group by cr.circuitid, cr.name, cr.location, cr.country
order by avg_lap_time;


-- 27. Who won the drivers championship when India hosted F1 for the first time?
with driver_champ_points as 
		(select r.year, concat(d.forename,' ',d.surname) as driver_name
		, sum(res.points) as tot_points
		, rank() over(partition by r.year order by sum(res.points) desc) as rnk
		from races r
		join driver_standings ds on ds.raceid=r.raceid
		join drivers d on d.driverid=ds.driverid
		join results res on res.raceid=r.raceid and res.driverid=ds.driverid 
		where r.year in (2011,2012,2013)
		group by r.year, res.driverid, concat(d.forename,' ',d.surname)),
	driver_champ as
		(select * from driver_champ_points where rnk=1),
	india_first_year as
		(select min(year) as first_yr from races 
		 where circuitid in (select circuitid from circuits where country='India'))
select year, driver_name
from driver_champ
where year = (select first_yr from india_first_year);

-- 28. Which driver has done the most lap time in F1 history?
with cte as (
	select lt.driverid, concat(d.forename,' ',d.surname) as driver_name, 
	sum(time) as total_lap_time, rank() over(order by sum(time) desc) as rnk
	from lap_times lt
	join drivers d using(driverid)
	group by 1,2
select driver_name, total_lap_time
from  cte
where rnk=1;

-- 29. Name the top 3 drivers who have got the most podium finishes in F1 (Top 3 race finishes)
with cte as 
	(select ds.driverid, concat(d.forename,' ',d.surname) as driver_name, 
	count(1) as no_of_podiums, rank() over(order by count(1) desc) as rnk
	from driver_standings ds 
	join drivers d on d.driverid=ds.driverid
	where ds.position <= 3
	group by 1, 2)
select driver_name, no_of_podiums
from cte
where rnk<=3;

-- 30. Which driver has the most pole position (no 1 in qualifying)
with cte as 
	(select q.driverid, concat(d.forename,' ',d.surname) as driver_name, 
	count(1) as pole_positions, rank() over(order by count(1) desc) as rnk
	from qualifying q
	join drivers d on d.driverid=q.driverid
	where position=1
	group by 1,2
	order by pole_positions desc)
select driver_name, pole_positions
from cte
where rnk=1;

