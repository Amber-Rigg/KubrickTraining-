USE [Crime]
GO

-- Crime Data FACT

 SELECT [Date]
	  ,cast(case [Police Force]
		  when 'Avon and Somerset Constabulary' then 1
			when 'Bedfordshire Police' then	2
			when 'Cambridgeshire Constabulary' then	3
			when 'Cheshire Constabulary'then 4
			when 'City of London Police' then 5
			when 'Cleveland Police' then	6
			when 'Cumbria Constabulary' then 7
			when 'Derbyshire Constabulary'	then 8
			when 'Devon & Cornwall Police'	then 9
			when 'Dorset Police' then 10
			when 'Durham Constabulary' then	11
			when 'Essex Police' then 12
			when 'Gloucestershire Constabulary' then 13
			when 'Greater Manchester Police' then 14
			when 'Hampshire Constabulary'	then 15
			when 'Hertfordshire Constabulary'	then 16
			when 'Humberside Police'	then 17
			when 'Kent Police' then 18
			when 'Lancashire Constabulary' then	19
			when 'Leicestershire Police' then 20
			when 'Lincolnshire Police'	then 21
			when 'Merseyside Police'	then 22
			when 'Metropolitan Police Service' then 23
			when 'Norfolk Constabulary' then 24
			when 'North Yorkshire Police'	then 25
			when 'Northamptonshire Police'	then 26
			when 'Northumbria Police'	then 27
			when 'Nottinghamshire Police'	then 28
			when 'South Yorkshire Police'	then 29
			when 'Staffordshire Police'	then 30
			when 'Suffolk Constabulary'	then 31
			when 'Surrey Police'	then 32
			when 'Sussex Police'	then 33
			when 'Thames Valley Police'	then 34
			when 'Warwickshire Police'	then 35
			when 'West Mercia Police'	then 36
			when 'West Midlands Police' then 37
			when 'West Yorkshire Police' then 38
			when 'Wiltshire Police'	then 39
		end as int) [Police ID] 
      ,[Longitude]
      ,[Latitude]
      ,[LSOA Code]
	  ,cast(case [Crime]
			when 'Anti-social behaviour'	then 1
			when'Burglary' then	2
			when 'Vehicle crime' then 3
			when 'Violence and sexual offences' then	4
			when 'Criminal damage and arson' then	5
			when 'Other theft' then	6
			when 'Public order'	then 7
			when 'Bicycle theft'	then 8
			when 'Drugs'	then 9
			when 'Theft from the person'	then 10
			when 'Other crime' then	11
			when 'Shoplifting' then 12
			when 'Robbery' then 13
			when 'Possession of weapons' then 14
		end as int) [Crime Type ID]
	  ,cast (case [Outcome]
		 when 'Offender given community sentence' then	1
			when 'Offender given conditional discharge'	then 2
			when 'Offender given suspended prison sentence'	then 3
			when 'Offender given a caution'	then 4
			when 'Formal action is not in the public interest' then	5
			when 'Suspect charged as part of another case'	then 6
			when 'Local resolution'	then 7
			when 'Offender sent to prison'	then 8
			when 'Offender given a drugs possession warning' then 9
			when 'Action to be taken by another organisation'	then 10
			when 'Offender given penalty notice'	then 11
			when 'Offender otherwise dealt with'	then 12
			when 'Offender fined'	then 13
			when 'Offender ordered to pay compensation'	then 14
			when 'Offender given absolute discharge' then	15
			when 'Offender deprived of property' then	16
		end as int) [Outcome ID]
      ,[Crime ID]
into Model.[Crime Data]
  FROM [Staged].[Crime Data]
GO

-- Date DIMENSION

SELECT distinct
	[Date]
  , DATEPART(YEAR,[Date]) [Year]
  , DATEPART(MONTH,[Date]) [Month]
  , DATEPART(QUARTER,[Date]) AS [Quarter]
  , DATEPART(QUARTER,DATEADD(MONTH,3,[Date])) AS [Finacial Quarter]
  , YEAR(DATEADD(MONTH,3,[Date])-1) AS [Financial Year]
into Model.[Date Data]
  FROM [Model].[Crime Data]
GO

-- Police Force Data DIMENSION

SELECT distinct
      [Police ID]
	 ,case [Police ID]
		 when 1 then'Avon and Somerset Constabulary'
			when 2	then 'Bedfordshire Police'
			when 3	then 'Cambridgeshire Constabulary'
			when 4	then 'Cheshire Constabulary'
			when 5	then 'City of London Police'
			when 6  then 'Cleveland Police'
			when 7	then 'Cumbria Constabulary'
			when 8	then 'Derbyshire Constabulary'
			when 9	then 'Devon & Cornwall Police'
			when 10	then 'Dorset Police'
			when 11	then 'Durham Constabulary'
			when 12	then 'Essex Police'
			when 13	then 'Gloucestershire Constabulary'
			when 14	then 'Greater Manchester Police'
			when 15	then 'Hampshire Constabulary'
			when 16	then 'Hertfordshire Constabulary'
			when 17	then 'Humberside Police'
			when 18 then 'Kent Police'
			when 19	then 'Lancashire Constabulary'
			when 20	then 'Leicestershire Police'
			when 21	then 'Lincolnshire Police'
			when 22	then 'Merseyside Police'
			when 23	then 'Metropolitan Police Service'
			when 24	then 'Norfolk Constabulary'
			when 25	then 'North Yorkshire Police'
			when 26 then 'Northamptonshire Police'
			when 27	then 'Northumbria Police'
			when 28	then 'Nottinghamshire Police'
			when 29	then 'South Yorkshire Police'
			when 30	then 'Staffordshire Police'
			when 31	then 'Suffolk Constabulary'
			when 32	then 'Surrey Police'
			when 33	then 'Sussex Police'
			when 34	then 'Thames Valley Police'
			when 35	then 'Warwickshire Police'
			when 36 then 'West Mercia Police'
			when 37 then 'West Midlands Police'
			when 38 then 'West Yorkshire Police'
			when 39	then 'Wiltshire Police'
		else 'N/A'
		end as [Police Force]
		,case
		   when  [Police ID] in(18,32,33) then 'South East'
		   when  [Police ID] in(2,16,34) then 'Thames & Chiltern'
		   when  [Police ID] in(1,9,13) then 'South West'
		   when  [Police ID] in(10,15,39) then 'Wessex'
		   when  [Police ID] in(30,35,36,37) then 'West Midlands'
		   when  [Police ID] in(8,20,21,26,28) then 'East Midlands'
		   when  [Police ID] in(3,12,31,24) then 'Easternn'
		   when  [Police ID] in(22,4) then 'Merseyside & Chesire '
		   when  [Police ID] in(17,38,29,25) then 'Yorkshire and Humberside'
		   when  [Police ID] in(7,14,19) then 'Greater Manchester, Lancashire & Cumbria'
		   when  [Police ID] in(6,11,27) then 'North East'
		   when  [Police ID] in(23,5) then 'London'
	   else 'N/A'
		end as [Region]
		,case [Police ID]
		 when 1 then'Avon and Somerset'
			when 2	then 'Bedfordshire'
			when 3	then 'Cambridgeshire'
			when 4	then 'Cheshire'
			when 5	then 'City of London'
			when 6  then 'Cleveland'
			when 7	then 'Cumbria'
			when 8	then 'Derbyshire'
			when 9	then 'Devon and Cornwall'
			when 10	then 'Dorset'
			when 11	then 'Durham'
			when 12	then 'Essex'
			when 13	then 'Gloucestershire'
			when 14	then 'Greater Manchester'
			when 15	then 'Hampshire'
			when 16	then 'Hertfordshire'
			when 17	then 'Humberside'
			when 18 then 'Kent'
			when 19	then 'Lancashire'
			when 20	then 'Leicestershire'
			when 21	then 'Lincolnshire'
			when 22	then 'Merseyside'
			when 23	then 'Metropolitan Police'
			when 24	then 'Norfolk'
			when 25	then 'North Yorkshire'
			when 26 then 'Northamptonshire'
			when 27	then 'Northumberland'
			when 28	then 'Nottinghamshire'
			when 29	then 'South Yorkshire'
			when 30	then 'Staffordshire'
			when 31	then 'Suffolk'
			when 32	then 'Surrey'
			when 33	then 'Sussex'
			when 34	then 'Thames Valley '
			when 35	then 'Warwickshire'
			when 36 then 'West Mercia'
			when 37 then 'West Midlands'
			when 38 then 'West Yorkshire'
			when 39	then 'Wiltshire'
		else 'N/A'
		end as [County]
		,cast(case
		   when  [Police ID] in(31) then 3
		   when  [Police ID] in(9,11,7) then 4
		   when  [Police ID] in(26) then 7
		   when  [Police ID] in(13,27) then 9
		   when  [Police ID] in(25,4,39) then 12
		   when  [Police ID] in(15) then 15
		   when  [Police ID] in(18,37,20,22,32) then 16
		   when  [Police ID] in(5,2,36,19) then 21
		   when  [Police ID] in(24,12,8) then 25
		   when  [Police ID] in(10,21,29) then 28
		   when  [Police ID] in(3,16) then 31
		   when  [Police ID] in(33,30,38) then 33
		   when  [Police ID] in(1,34,35,14) then 36
		   when  [Police ID] in(6,17) then 40
		   when  [Police ID] in(28) then 42
		   when  [Police ID] in(23) then 43
		end as tinyint) [Detection Ranking (incl. Wales)]
			,cast(case
		   when  [Police ID] in(31) then 35
		   when  [Police ID] in(9,11,7) then 34
		   when  [Police ID] in(26) then 33
		   when  [Police ID] in(13,27) then 31
		   when  [Police ID] in(25,4,39) then 30
		   when  [Police ID] in(15) then 29
		   when  [Police ID] in(18,37,20,22,32) then 28
		   when  [Police ID] in(5,2,36,19) then 27
		   when  [Police ID] in(24,12,8) then 26
		   when  [Police ID] in(10,21,29) then 25
		   when  [Police ID] in(3,16) then 24
		   when  [Police ID] in(33,30,38) then 23
		   when  [Police ID] in(1,34,35,14) then 22
		   when  [Police ID] in(6,17) then 21
		   when  [Police ID] in(28) then 20
		   when  [Police ID] in(23) then 15
		end as tinyint)[% of Recorderd Crimes Detected]
into Model.[Police Force Data]
  FROM [Model].[Crime Data]
where [Police ID] is not null
order by [Police ID] asc

-- Crime Type Dimension

SELECT distinct
      [Crime Type ID]
	  ,case [Crime Type ID]
			when 1	then 'Anti-social behaviour'
			when 2	then 'Burglary'
			when 3	then 'Vehicle crime'
			when 4	then 'Violence and sexual offences'
			when 5	then 'Criminal damage and arson'
			when 6	then 'Other theft'
			when 7	then 'Public order'
			when 8	then 'Bicycle theft'
			when 9	then 'Drugs'
			when 10	then 'Theft from the person'
			when 11	then 'Other crime'
			when 12	then 'Shoplifting'
			when 13	then 'Robbery'
			when 14	then 'Possession of weapons'
		end as [Crime Type]
		,cast(case 
			when  [Crime Type ID] in(1,4) then 1
			when  [Crime Type ID] in(2,3,5,6,8,10,12,13) then 2
			when  [Crime Type ID] in(7) then 3
			when  [Crime Type ID] in(9,14) then 4
			when  [Crime Type ID] in(11) then 5
		end as int)[Crime Category ID]
		,cast(case 
			when  [Crime Type ID] in(1,8,10,12) then 1
			else 2		
		end as int) [Felony/Misdemeanor ID]
		,cast(case 
			when  [Crime Type ID] in(7,9,14) then 1
			else 2		
		end as int) [Victim/Victimless ID]
		,cast(case 
			when  [Crime Type ID] in(12,8) then 1
			when  [Crime Type ID] in(1,6,7,10) then 2
			when  [Crime Type ID] in(3,11) then 3
			when  [Crime Type ID] in(13,2) then 4
			when  [Crime Type ID] in(4,5,9,14) then 5
		end as tinyint) [5 Scale Severity Rating]
into Model.[Crime Type Data]
  FROM [Model].[Crime Data]
GO

-- Crime Category LOOKUP

SELECT distinct
	 cast(case 
			when  [Crime Type ID] in(1,4) then 1
			when  [Crime Type ID] in(2,3,5,6,8,10,12,13) then 2
			when  [Crime Type ID] in(7) then 3
			when  [Crime Type ID] in(9,14) then 4
			when  [Crime Type ID] in(11) then 5
		end as int)[Crime Category ID]
		,case 
			when  [Crime Type ID] in(1,4) then 'Violent Crime'
			when  [Crime Type ID] in(2,3,5,6,8,10,12,13) then 'Property Crime'
			when  [Crime Type ID] in(7) then 'Political Crime'
			when  [Crime Type ID] in(9,14) then 'Possession Crime'
			when  [Crime Type ID] in(11) then 'Other Crime'
		end [Crime Category]
into Model.[Crime Category Data]
  FROM [Model].[Crime Data]

-- Felony/Misdemeanor LOOKUP

SELECT distinct
		case 
			when  [Crime Type ID] in(1,8,10,12) then 'Misdemeanor'
			else 'Felony'		
		end [Felony/Misdemeanor]
		,cast(case 
			when  [Crime Type ID] in(1,8,10,12) then 1
			else 2		
		end as int) [Felony/Misdemeanor ID]
into Model.[Felony/Misdemeanor Data]
FROM [Model].[Crime Data]

-- Victim/Victimless Data LOOKUP

SELECT distinct
			case 
			when  [Crime Type ID] in(7,9,14) then 'Victimless'
			else 'Victim'		
		end as [Victim/Victimless]
		,cast(case 
			when  [Crime Type ID] in(7,9,14) then 1
			else 2		
		end as int) [Victim/Victimless ID]
into Model.[Victim/Victimless Data]
FROM [Model].[Crime Data]

-- Outcome Type Data DIMENSION

SELECT distinct
      [Outcome ID]
	  ,case [Outcome ID]
			when 1	then 'Offender given community sentence'
			when 2	then 'Offender given conditional discharge'
			when 3	then 'Offender given suspended prison sentence'
			when 4	then 'Offender given a caution'
			when 5	then 'Formal action is not in the public interest'
			when 6	then 'Suspect charged as part of another case'
			when 7	then 'Local resolution'
			when 8	then 'Offender sent to prison'
			when 9	then 'Offender given a drugs possession warning'
			when 10	then 'Action to be taken by another organisation'
			when 11	then 'Offender given penalty notice'
			when 12	then 'Offender otherwise dealt with'
			when 13	then 'Offender fined'
			when 14	then 'Offender ordered to pay compensation'
			when 15	then 'Offender given absolute discharge'
			when 16	then 'Offender deprived of property'
		end as [Outcome Type]
		,case 
			when  [Outcome ID] in(5,6,7,10,12) then 'False'
			else 'True'
		end as [Case Resolved Inclusively]
		,cast(case 
			when  [Outcome ID] in(2,5,15) then 1
			when  [Outcome ID] in(4) then 2
			when  [Outcome ID] in(1,9,11,13,14) then 3
			when  [Outcome ID] in(16) then 4
			when  [Outcome ID] in(3,8) then 5
			else 0
		end as int) [5 Scale Severity Rating]
into Model.[Outcome Type Data]
FROM [Model].[Crime Data]
where [Outcome ID] is not null

-- Geography Dimension

SELECT distinct
      CD.[LSOA Code]
      ,CD.[LSOA Name]
	  ,reverse(substring(reverse(CD.[LSOA Name]),5,50)) [Local Authority District Name]
	  ,substring(CD.[LSOA Code],2,2) [SOA Layer]
	  ,substring(CD.[LSOA Code],4,6) [Unique Area Tag]
	  ,substring((reverse(CD.[LSOA Name])),1,1) [MSOA Indeitfication]
	  ,reverse(substring((reverse(CD.[LSOA Name])),2,3)) [Middle SOA Label]
into Model.[Geo without Police Force]
  FROM [Staged].[Crime Data] CD

SELECT 
		[LSOA Code]
      ,[LSOA Name]
      ,replace(replace([Local Authority District Name],' and ',' & '),'London City of','City of London') [Local Authority District]
      ,[SOA Layer]
      ,[Unique Area Tag]
      ,[MSOA Indeitfication]
      ,[Middle SOA Label]
into [Model].[Geo without Police Correct]
  FROM [Model].[Geo without Police Force]

SELECT replace(replace([Local Authority District],' and ',' & '),'London City of','City of London') [Local Authority District]
      ,[Region]
      ,replace([Police Force Area],'London City of','City of London') [Police Force Area]
into Model.[Lad Conversion]
  FROM [Staged].[LAD Conversion]


  SELECT distinct
		GP.[LSOA Code]
      ,GP.[LSOA Name]
      ,GP.[SOA Layer]
      ,GP.[Unique Area Tag]
      ,GP.[MSOA Indeitfication]
      ,GP.[Middle SOA Label]
	  ,LC.[Region]
	  ,case GP.[Local Authority District]
	  	when 'Barking & Dagenham'	then 1
		when 'Barnet'				then 2
		when 'Bexley'				then 3
		when 'Brent'				then 4
		when 'Bromley'				then 5
		when 'Camden'				then 6
		when 'Croydon'				then 7
		when 'Ealing'				then 8
		when 'Enfield'			then 9
		when 'Greenwich'				then 10
		when 'Hackney'			then 11
		when 'Hammersmith & Fulham'	then 12
		when 'Haringey'				then 13
		when 'Harrow'				then 14
		when 'Havering'				then 15
		when 'Hillingdon'			then 16
		when 'Hounslow'				then 17
		when 'Islington'				then 18
		when 'Kensington & Chelsea'	then 19
		when 'Kingston upon Thames'	then 20
		when 'Lambeth'				then 21
		when 'Lewisham'				then 22
		when 'Merton'				then 23
		when 'Newham'				then 24
		when 'Redbridge'				then 25
		when 'Richmond upon Thames'	then 26
		when 'Southwark'				then 27
		when 'Sutton'				then 28
		when 'Tower Hamlets'			then 29
		when 'Waltham Forest'		then 30
		when 'Wandsworth'			then 31
		when 'Westminster'			then 32
		else ' '
end as [Local Authority District ID]
	
,case LC.[Police Force Area]
		when 'Avon & Somerset' then	1
		when 'Bedfordshire'	then 2
		when 'Cambridgeshire'	then 3
		when 'Cheshire'	then 4
		when 'City of London'	then 5
		when 'Cleveland'	then 6
		when 'Cumbria'	then 7
		when 'Derbyshire'	then 8
		when 'Devon & Cornwall'	then 9
		when 'Dorset'	then 10
		when 'Durham'	then 11
		when 'Essex'	then 12
		when 'Gloucestershire' then	13
		when 'Greater Manchester'	then 14
		when 'Hampshire'	then 15
		when 'Hertfordshire'	then 16
		when 'Humberside'	then 17
		when 'Kent'	then 18
		when 'Lancashire'	then 19
		when 'Leicestershire'	then 20
		when 'Lincolnshire'	then 21
		when 'Merseyside'	then 22
		when 'Metropolitan Police'	then 23
		when 'Norfolk'	then 24
		when 'North Yorkshire'	then 25
		when 'Northamptonshire' then	26
		when 'Northumbria'	then 27
		when 'Nottinghamshire' then 28
		when 'South Yorkshire'	then 29
		when 'Staffordshire'	then 30
		when 'Suffolk'	then 31
		when 'Surrey'	then 32
		when 'Sussex'	then 33
		when 'Thames Valley' then	34
		when 'Warwickshire'	then 35
		when 'West Mercia'	then 36
		when 'West Midlands'	then 37
		when 'West Yorkshire'	then 38
		when 'Wiltshire'	then 39
end as [Police Force Area ID]
into Model.[Geography Data]
  FROM [Model].[Geo without Police Correct] GP
  inner join [Model].[Lad Conversion] LC
on GP.[Local Authority District]=LC.[Local Authority District]

-- Knife Crime London FACT

SELECT replace([London Borough],' and ',' & ') [London Borough]
      ,[2016/2017 Knife Crime]
      ,[2016/2017 Knife Crime with Injury]
      ,[2017/2018 Knife Crime]
      ,[2017/2018 Knife Crime with Injury]
into Model.[Knife Crime London]
  FROM [Staged].[Knife Crime London]
where [London Borough] != 'Grand Total'
GO

SELECT distinct 
      GD.[Local Authority District ID]
	  ,KC.[2016/2017 Knife Crime] [Knife Crime]
      ,KC.[2016/2017 Knife Crime with Injury] [Knife Crime with Injury]
into Model.[London Knife Crime 2016/2017]
  FROM [Model].[Geography Data] GD
inner join Model.[Knife Crime London] KC
on GD.[Local Authority District]=KC.[London Borough]

select
*
from Model.[London Knife Crime 2016/2017]

Alter table Model.[London Knife Crime 2016/2017]
Add [Year] int 
UPDATE Model.[London Knife Crime 2016/2017]
SET [Year] = 2016

select
*
from Model.[London Knife Crime 2016/2017]

SELECT distinct 
      GD.[Local Authority District ID ]
	  ,KC.[2017/2018 Knife Crime] [Knife Crime]
      ,KC.[2017/2018 Knife Crime with Injury] [Knife Crime with Injury]
into Model.[London Knife Crime 2017/2018]
  FROM [Model].[Geography Data] GD
inner join [Model].[Knife Crime London] KC
on GD.[Local Authority District]=KC.[London Borough]

Alter table Model.[London Knife Crime 2017/2018]
Add [Year] int 
UPDATE Model.[London Knife Crime 2017/2018]
SET [Year] = 2017


select * 
into [Model].[Knife Crime London Data]
from 
(
SELECT     *
FROM         Model.[London Knife Crime 2017/2018]
UNION
SELECT     *
FROM        Model.[London Knife Crime 2016/2017]
)a

--Knife Crime England FACT

SELECT replace(replace([Police Region],' and ',' & '),'Northumberland','Northumbria') [Police Force Area]
      ,[2013/2014 Knife Crime]
      ,[2013/2014 Knife Crime(per 100,000 population)]
      ,[2014/2015 Knife Crime]
      ,[2014/2015 Knife Crime(per 100,000 population)]
      ,[2015/2016 Knife Crime]
      ,[2015/2016 Knife Crime(per 100,000 population)]
      ,[2016/2017 Knife Crime]
      ,[2016/2017 Knife Crime(per 100,000 population)]
      ,[2017/2018 Knife Crime]
      ,[2017/2018 Knife Crime(per 100,000 population)]
into [Model].[Knife Crime Country]
  FROM [Staged].[Knife Crime Country]


SELECT Distinct
   GD.[Police Force Area ID]
	  ,KC.[2013/2014 Knife Crime][Knife Crime]
      ,KC.[2013/2014 Knife Crime(per 100,000 population)] [Knife Crime(per 100,000 population)]
into Model.[National Knife Crime 2013/2014 Data]
  FROM Model.[Geography Data] GD
join [model].[Knife Crime Country] KC
on GD.[Police Force Area]=KC.[Police Force Area]

GO

Alter table Model.[National Knife Crime 2013/2014 Data]
Add [Financial Year] int 
UPDATE Model.[National Knife Crime 2013/2014 Data]
SET [Financial Year] = 2013

select
*
from Model.[National Knife Crime 2013/2014 Data]

SELECT distinct
		 GD.[Police Force Area ID]
	  ,KC.[2014/2015 Knife Crime] [Knife Crime]
      ,KC.[2014/2015 Knife Crime(per 100,000 population)][Knife Crime(per 100,000 population)]
into Model.[National Knife Crime 2014/2015 Data]
  FROM Model.[Geography Data] GD
join [Model].[Knife Crime Country] KC
on GD.[Police Force Area]=KC.[Police Force Area]
GO

Alter table Model.[National Knife Crime 2014/2015 Data]
Add [Financial Year] int 
UPDATE Model.[National Knife Crime 2014/2015 Data]
SET [Financial Year] = 2014


SELECT distinct
		 GD.[Police Force Area ID]
	  ,KC.[2015/2016 Knife Crime] [Knife Crime]
      ,KC.[2015/2016 Knife Crime(per 100,000 population)][Knife Crime(per 100,000 population)]
into Model.[National Knife Crime 2015/2016 Data]
  FROM  Model.[Geography Data] GD
join [model].[Knife Crime Country] KC
on   GD.[Police Force Area]=KC.[Police Force Area]
GO

Alter table Model.[National Knife Crime 2015/2016 Data]
Add [Financial Year] int 
UPDATE Model.[National Knife Crime 2015/2016 Data]
SET [Financial Year] = 2015


SELECT distinct
		GD.[Police Force Area ID]
	  ,KC.[2016/2017 Knife Crime] [Knife Crime]
      ,KC.[2016/2017 Knife Crime(per 100,000 population)][Knife Crime(per 100,000 population)]
into Model.[National Knife Crime 2016/2017 Data]
  FROM Model.[Geography Data] GD
join [model].[Knife Crime Country] KC
on GD.[Police Force Area]=KC.[Police Force Area]
GO

Alter table Model.[National Knife Crime 2016/2017 Data]
Add [Financial Year] int 
UPDATE Model.[National Knife Crime 2016/2017 Data]
SET [Financial Year] = 2016


SELECT distinct
		GD.[Police Force Area ID]
	  ,KC.[2017/2018 Knife Crime] [Knife Crime]
      ,KC.[2017/2018 Knife Crime(per 100,000 population)][Knife Crime(per 100,000 population)]
into Model.[National Knife Crime 2017/2018 Data]
  FROM Model.[Geography Data] GD
join [model].[Knife Crime Country] KC
on GD.[Police Force Area]=KC.[Police Force Area]
GO

Alter table Model.[National Knife Crime 2017/2018 Data]
Add [Financial Year] int 
UPDATE Model.[National Knife Crime 2017/2018 Data]
SET [Financial Year] = 2017

select * 
into [Model].[Knife Crime Country Data]
from 
(
SELECT     *
FROM         Model.[National Knife Crime 2017/2018 Data]
UNION
SELECT     *
FROM         Model.[National Knife Crime 2016/2017 Data]
UNION
SELECT     *
FROM         Model.[National Knife Crime 2015/2016 Data]
UNION
SELECT     *
FROM         Model.[National Knife Crime 2014/2015 Data]
)a


-- Population Data DIMENSION

SELECT 
	GD.[LSOA Code]
	,PD.[Population 2017] [Population]
into Model.[Population 2017]
  FROM [Staged].[LSAO Population] PD
inner join  Model.[Geography Data] GD
on PD.[LSAO Code]=GD.[LSOA Code]


Alter table Model.[Population 2017]
Add [Year] int 
UPDATE Model.[Population 2017]
SET [Year] = 2017

SELECT 
	GD.[LSOA Code]
	,PD.[Population 2016] [Population]
into Model.[Population 2016]
  FROM [Staged].[LSAO Population] PD
inner join  Model.[Geography Data] GD
on PD.[LSAO Code]=GD.[LSOA Code]
 
Alter table Model.[Population 2016]
Add [Year] int 
UPDATE Model.[Population 2016]
SET [Year] = 2016

 SELECT 
	GD.[LSOA Code]
	,PD.[Population 2015] [Population]
into Model.[Population 2015]
  FROM [Staged].[LSAO Population] PD
inner join  Model.[Geography Data] GD
on PD.[LSAO Code]=GD.[LSOA Code]

Alter table Model.[Population 2015]
Add [Year] int 
UPDATE Model.[Population 2015]
SET [Year] = 2015

SELECT 
	GD.[LSOA Code]
	,PD.[Population 2014] [Population]
into Model.[Population 2014]
  FROM [Staged].[LSAO Population] PD
inner join  Model.[Geography Data] GD
on PD.[LSAO Code]=GD.[LSOA Code]

Alter table Model.[Population 2014]
Add [Year] int 
UPDATE Model.[Population 2014]
SET [Year] = 2014


select
*
into Model.[Population Data]
from (
SELECT     *
FROM         Model.[Population 2017]
UNION
SELECT     *
FROM         Model.[Population 2016]
UNION
SELECT     *
FROM         Model.[Population 2015]
UNION
SELECT     *
FROM        Model.[Population 2014]
)a

