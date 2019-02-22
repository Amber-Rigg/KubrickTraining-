---London
-- Crime Type

CREATE VIEW CrimeTypeComparisonLondon AS
SELECT Distinct
	FYL.[Financial Year] [Financial Year]  
	  ,Count(CTD.[Crime Type]) over(partition by [Crime Type], [Local Authority District]) [Reported Offences Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Crime Type], [Local Authority District]) [Reported Offences Punishment Severity]
	  ,LADL.[Local Authority District][Local Authority District]
	  ,CTD.[Crime Type]
	  ,KCLD.[Knife Crime] [Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Local Authority District LOOKUP] LADL
on GD.[Local Authority District ID]=LADL.[Local Authority District ID]
inner join [Model].[Knife Crime London DIMENSION] KCLD
on LADL.[Local Authority District ID]=KCLD.[Local Authority District ID ]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCLD.[Financial Year]=FYL.[Financial Year]
;

-- Crime Category

CREATE VIEW CrimeCategoryComparisonLondon AS
SELECT Distinct
		FYL.[Financial Year] [Financial Year]
	  ,Count(CCL.[Crime Category]) over(partition by [Crime Category], [Local Authority District]) [Reported Offences Category Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating]as float)) over (partition by [Crime Type], [Local Authority District]) [Reported Offences Punishment Severity]
	  ,LADL.[Local Authority District][Local Authority District]
	  ,CCL.[Crime Category]
	  ,KCLD.[Knife Crime] [Reported Knife Crime Offences]
   FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Crime Category LOOKUP] CCL
on CTD.[Crime Category ID]=CCL.[Crime Category ID]
inner join [Model].[Local Authority District LOOKUP] LADL
on GD.[Local Authority District ID]=LADL.[Local Authority District ID]
inner join [Model].[Knife Crime London DIMENSION] KCLD
on LADL.[Local Authority District ID]=KCLD.[Local Authority District ID ]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCLD.[Financial Year]=FYL.[Financial Year]
;


-- Felony or Misdemeanor 

CREATE VIEW CrimeFelonyorMisdemeanorComparisonLondon AS
SELECT Distinct
		FYL.[Financial Year] [Financial Year]
	  ,Count([Felony/Misdemeanor]) over(partition by [Felony/Misdemeanor], [Local Authority District]) [Reported Offence Felony/Misdemeanor Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Felony/Misdemeanor], [Local Authority District]) [Reported Offences Punishment Severity]
	  ,LADL.[Local Authority District][Local Authority District]
	  ,FML.[Felony/Misdemeanor] [Felony or Misdemeanor]
	  ,KCLD.[Knife Crime] [Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join [Model].[Felony/Misdemeanor LOOKUP] FML
on CTD.[Felony/Misdemeanor ID]= FML.[Felony/Misdemeanor ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Local Authority District LOOKUP] LADL
on GD.[Local Authority District ID]=LADL.[Local Authority District ID]
inner join [Model].[Knife Crime London DIMENSION] KCLD
on LADL.[Local Authority District ID]=KCLD.[Local Authority District ID ]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCLD.[Financial Year]=FYL.[Financial Year]


-- AVG Crime Severity

CREATE VIEW CrimeSeverityComparisonLondon AS
SELECT Distinct
		FYL.[Financial Year] [Financial Year]
	  ,LADL.[Local Authority District][Local Authority District]
	  ,AVG(cast(CTD.[5 Scale Severity Rating] as Float)) over(partition by [Local Authority District]) [Reported Offences Severity]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Local Authority District]) [Reported Offences Punishment Severity]
	  ,KCLD.[Knife Crime] [Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Local Authority District LOOKUP] LADL
on GD.[Local Authority District ID]=LADL.[Local Authority District ID]
inner join [Model].[Knife Crime London DIMENSION] KCLD
on LADL.[Local Authority District ID]=KCLD.[Local Authority District ID ]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCLD.[Financial Year]=FYL.[Financial Year]

--England
--- Crime Type
use crime 
go

CREATE VIEW CrimeTypeComparisonEngland AS
SELECT Distinct
	FYL.[Financial Year] [Financial Year]
	  ,Count(CTD.[Crime Type]) over(partition by [Crime Type], [Police Force Area]) [Reported Offences Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Crime Type], [Police Force Area]) [Reported Offences Punishment Severity]
	  ,RDL.[Police Force Area] [England Police Force Area]
	  ,CTD.[Crime Type]
	  ,KCCD.[Knife Crime] [Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Region Data LOOKUP] RDL
on GD.[Police Force Area ID]=RDL.[Police Force Area ID]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join[Model].[Knife Crime Country DIMENSION] KCCD
on RDL.[Police Force Area ID]=KCCD.[Police Force Area ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCCD.[Financial Year]=FYL.[Financial Year];

-- Crime Category

CREATE VIEW CrimeCategoryComparisonEngland AS
SELECT Distinct
		FYL.[Financial Year] [Financial Year]
	  ,Count(CCL.[Crime Category]) over(partition by [Crime Category], [Police Force Area]) [Reported Offences Category Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating]as float)) over (partition by [Crime Type], [Police Force Area]) [Reported Offences Punishment Severity]
	  ,RDL.[Police Force Area] [England Police Force Area]
	  ,CCL.[Crime Category]
	  ,KCCD.[Knife Crime][Reported Knife Crime Offences]
   FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Region Data LOOKUP] RDL
on GD.[Police Force Area ID]=RDL.[Police Force Area ID]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join[Model].[Knife Crime Country DIMENSION] KCCD
on RDL.[Police Force Area ID]=KCCD.[Police Force Area ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Crime Category LOOKUP] CCL
on CTD.[Crime Category ID]=CCL.[Crime Category ID]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCCD.[Financial Year]=FYL.[Financial Year];


-- Felony or Misdemeanor 

CREATE VIEW CrimeFelonyorMisdemeanorComparisonEngland AS
SELECT Distinct
		FYL.[Financial Year] [Financial Year]
	  ,Count([Felony/Misdemeanor]) over(partition by [Felony/Misdemeanor], [Police Force Area]) [Reported Offence Felony/Misdemeanor Total]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Felony/Misdemeanor], [Police Force Area]) [Reported Offences Punishment Severity]
	  ,RDL.[Police Force Area] [England Police Force Area]
	  ,FML.[Felony/Misdemeanor] [Felony or Misdemeanor]
	  ,KCCD.[Knife Crime][Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Region Data LOOKUP] RDL
on GD.[Police Force Area ID]=RDL.[Police Force Area ID]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join [Model].[Felony/Misdemeanor LOOKUP] FML
on CTD.[Felony/Misdemeanor ID]= FML.[Felony/Misdemeanor ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join[Model].[Knife Crime Country DIMENSION] KCCD
on RDL.[Police Force Area ID]=KCCD.[Police Force Area ID]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCCD.[Financial Year]=FYL.[Financial Year];

-- AVG Crime Severity

CREATE VIEW CrimeSeverityComparisonEngland AS
SELECT Distinct
FYL.[Financial Year] [Financial Year]
	  ,RDL.[Police Force Area] [England Police Force Area]
	  ,AVG(cast(CTD.[5 Scale Severity Rating] as Float)) over(partition by [Police Force Area]) [Reported Offences Severity]
	  ,AVG(cast(OTDD.[5 Scale Severity Rating] as float)) over (partition by [Police Force Area]) [Reported Offences Punishment Severity]
	  ,KCCD.[Knife Crime] [Reported Knife Crime Offences]
  FROM [Model].[Crime Data FACT] CDF
inner join [Model].[Date DIMENSION] DD
on DD.[Date]=CDF.[Date]
inner join [Model].[Geography DIMENSION] GD
on GD.[LSOA Code]=CDF.[LSOA Code]
inner join [Model].[Region Data LOOKUP] RDL
on GD.[Police Force Area ID]=RDL.[Police Force Area ID]
inner join [Model].[Crime Type DIMENSION] CTD
on CTD.[Crime Type ID]=CDF.[Crime Type ID]
inner join[Model].[Knife Crime Country DIMENSION] KCCD
on RDL.[Police Force Area ID]=KCCD.[Police Force Area ID]
inner join [Model].[Outcome Type Data DIMENSION] OTDD
on OTDD.[Outcome ID]= CDF.[Outcome ID]
inner join [Model].[Financial Year LOOKUP] FYL
on DD.[Financial Year]=FYL.[Financial Year]
and KCCD.[Financial Year]=FYL.[Financial Year];