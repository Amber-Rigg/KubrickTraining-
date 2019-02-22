--Cleaning

-- Reported Offences

SELECT distinct
[Crime ID]
	,cast(concat ([Month],-01) as date) [Date]
     ,Ltrim([Falls within]) [Police Force] 
     ,ltrim(try_cast([Longitude] as float)) [Longitude]
     ,ltrim(try_cast([Latitude] as float)) [Latitude]
     ,ltrim(cast([LSOA code] as varchar(9))) [LSOA Code]
     ,ltrim(cast([LSOA name] as varchar(50))) [LSOA name]
     ,ltrim([Crime type]) [Crime]
     ,ltrim([Last outcome category]) [Outcome]
into [Staged].[Crime Data with Original Crime ID]
  FROM [dbo].[Full Crime Data]
  where  [Crime ID] is not null
and [Last outcome category] not in ('Under investigation','Further investigation is not in the public interest','Court case unable to proceed','Status update unavailable','Investigation complete; no suspect identified','Court result unavailable','Unable to prosecute suspect','Defendant found not guilty','Awaiting court outcome')
and [Location] != 'No Location'
and substring([LSOA Code],1,1) not in ('K','S','N','W')
and [Falls within] not in ('Dyfed-Powys Police','South Wales Police')
and [Crime type] = 'Anti-social behaviour'
-- This had to be done with the [Crime ID] to ensure the distinct was only removing the duplicates.
-- A new table was created without the [Crime ID]
SELECT 
      [Date]
      ,[Police Force]
      ,[Longitude]
      ,[Latitude]
      ,[LSOA Code]
      ,[LSOA name]
      ,[Crime]
      ,[Outcome]
into [Staged].[Crime Data]
  FROM [Staged].[Crime Data with Original Crime ID]
GO
-- The final stage is to add an identity column 
Alter table Staged.[Crime Data]
add [Crime ID] int identity primary key

-- LSOA Population

SELECT	
	   cast([F2] as varchar(9)) [LAD Code]
      ,cast([F21] as int) [Population 2014]
      ,cast([F22] as int) [Population 2015]
      ,cast([F23] as int) [Population 2016]
into Staged.[Population]
  FROM [dbo].[Population]
where substring([F2],1,1) not in ('K','S','N','W')
 and [F2] is not null
 and [F2] != 'LAU1 code'

GO

-- LAD Conversion

SELECT 
      cast([Local Authority] as varchar(50)) [Local Authority District]
      ,cast([Region] as varchar(50)) [Region]
      ,cast([Police force area] as varchar(50)) [Police Force Area]
into Staged.[LAD Conversion]
  FROM [dbo].[LAD to Force]
GO

-- Knife Crime London

SELECT cast([F1] as varchar(50)) [London Borough]
      ,cast([2016/17] as int) [2016/2017 Knife Crime]
      ,cast([F4] as int)[2016/2017 Knife Crime with Injury]
      ,cast([2017/18] as int)[2017/2018 Knife Crime]
      ,cast([F7] as int)[2017/2018 Knife Crime with Injury]
into Staged.[Knife Crime London]
  FROM [dbo].[Knife Crime London]
  where [2016/17] is not null

-- Knife Crime England

SELECT cast([F1] as varchar(50)) [Police Region]
      ,cast([2013/14] as int) [2013/2014 Knife Crime]
      ,cast(isnull([F13],' ') as int)[2013/2014 Knife Crime(per 100,000 population)]
      ,cast([2014/15] as int)[2014/2015 Knife Crime]
      ,cast(isnull([F15],' ') as int)[2014/2015 Knife Crime(per 100,000 population)]
      ,cast([2015/16] as int)[2015/2016 Knife Crime]
      ,cast(isnull([F17],' ') as int)[2015/2016 Knife Crime(per 100,000 population)]
      ,cast([2016/17] as int)[2016/2017 Knife Crime]
      ,cast(isnull([F19],' ') as int)[2016/2017 Knife Crime(per 100,000 population)]
      ,cast([2017/18] as int)[2017/2018 Knife Crime]
      ,cast(isnull([F21],' ') as int)[2017/2018 Knife Crime(per 100,000 population)]
into Staged.[Knife Crime Country]
  FROM [dbo].[Knife Crime Country]
  where [F1] not in( 
  'British Transport Police','ENGLAND AND WALES4,5,6,7,8','Dyfed-Powys','Gwent','North Wales','South Wales','WALES','North East Region','North West Region','Yorkshire and the Humber Region','East Midlands Region','West Midlands Region','East of England Region','London','South East Region','South West Region')
  and [F1] is not null
