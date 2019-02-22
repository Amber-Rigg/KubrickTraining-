-- LOOKUP TABLE
-- Region Data LOOKUP

SELECT 
replace(replace([Police Region],' and ',' & '),'Northumberland','Northumbria') [Police Force Area]
,case [Police Region]
		when 'Avon and Somerset'	then 1
		when 'Bedfordshire'			then 2
		when 'Cambridgeshire'		then 3
		when 'Cheshire'				then 4
		when 'City of London'		then 5
		when 'Cleveland'			then 6
		when 'Cumbria'				then 7
		when 'Derbyshire'			then 8
		when 'Devon and Cornwall'	then 9
		when 'Dorset'				then 10
		when 'Durham'				then 11
		when 'Essex'				then 12
		when 'Gloucestershire'		then 13
		when 'Greater Manchester'	then 14
		when 'Hampshire'			then 15
		when 'Hertfordshire'		then 16
		when 'Humberside'			then 17
		when 'Kent'					then 18
		when 'Lancashire'			then 19
		when 'Leicestershire'		then 20
		when 'Lincolnshire'			then 21
		when 'Merseyside'			then 22
		when 'Metropolitan Police'	then 23
		when 'Norfolk'				then 24
		when 'North Yorkshire'		then 25
		when 'Northamptonshire'		then 26
		when 'Northumberland'		then 27
		when 'Nottinghamshire'		then 28
		when 'South Yorkshire'		then 29
		when 'Staffordshire'		then 30
		when 'Suffolk'				then 31
		when 'Surrey'				then 32
		when 'Sussex'				then 33
		when 'Thames Valley'		then 34
		when 'Warwickshire'			then 35
		when 'West Mercia'			then 36
		when 'West Midlands'		then 37
		when 'West Yorkshire'		then 38
		when 'Wiltshire'			then 39
end as [Police Force Area ID]
into model.[Region Data]
  FROM [Staged].[Knife Crime Country]

-- Local Authority District LOOKUP

SELECT 
replace([London Borough],' and ',' & ') [Local Authority District]
,case [London Borough]
	  	when 'Barking and Dagenham'	then 1
		when 'Barnet'				then 2
		when 'Bexley'				then 3
		when 'Brent'				then 4
		when 'Bromley'				then 5
		when 'Camden'				then 6
		when 'Croydon'				then 7
		when 'Ealing'				then 8
		when 'Enfield'				then 9
		when 'Greenwich'			then 10
		when 'Hackney'				then 11
		when 'Hammersmith and Fulham'	then 12
		when 'Haringey'				then 13
		when 'Harrow'				then 14
		when 'Havering'				then 15
		when 'Hillingdon'			then 16
		when 'Hounslow'				then 17
		when 'Islington'			then 18
		when 'Kensington and Chelsea'	then 19
		when 'Kingston upon Thames'	then 20
		when 'Lambeth'				then 21
		when 'Lewisham'				then 22
		when 'Merton'				then 23
		when 'Newham'				then 24
		when 'Redbridge'				then 25
		when 'Richmond upon Thames'	then 26
		when 'Southwark'			then 27
		when 'Sutton'				then 28
		when 'Tower Hamlets'		then 29
		when 'Waltham Forest'		then 30
		when 'Wandsworth'			then 31
		when 'Westminster'			then 32
		else ' '
end as [Local Authority District ID]
into Model.[Local Authority District]
  FROM [Staged].[Knife Crime London]
where [London Borough] != 'Grand Total'

-- Financial Year

CREATE TABLE Model.[Financial Year LOOKUP] (
  [Financial Year]INT NOT NULL);

INSERT INTO Model.[Financial Year LOOKUP]
    ([Financial Year]) 
VALUES 
    (2014),
    (2015),
    (2016),
	(2017),
	(2018);