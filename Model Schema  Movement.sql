USE [Crime]
GO

create schema [Building Model]
go

ALTER SCHEMA [Building Model]
transfer [Staged].[S Crime Data]

--transfer[Staged].[ S Crime Data with Original Crime ID]

--transfer[Staged].[S Knife Crime Country]

--transfer[Staged].[S Knife Crime London]

--transfer[Staged].[S LAD Conversion]

--transfer[Staged].[S LSAO Population]

--transfer[Model].[Knife Crime London]

--transfer[Model].[Knife Crime Country]

--transfer[Model].[Geo without Police Force]

--transfer[Model].[Geo without Police Correct]

--transfer[Model].[Distinct LSAO] 

--transfer[Model].[Population 2016]

--transfer[Model].[Population 2015]

--transfer[Model].[Population 2014]

--transfer[Model].[National Knife Crime 2017/2018 Data]

--transfer[Model].[National Knife Crime 2016/2017 Data]

--transfer[Model].[National Knife Crime 2015/2016 Data]

--transfer[Model].[National Knife Crime 2014/2015 Data]

--transfer[Model].[National Knife Crime 2013/2014 Data]

--transfer[Model].[London Knife Crime 2017/2018]

--transfer[Model].[London Knife Crime 2016/2017]

--transfer[Model].[Police Force Data Non Distinct] 

--transfer[Model].[London Knife Crime 2016/2017]

--transfer[Model].[London Knife Crime 2017/2018]

--transfer[Model].[National Knife Crime 2013/2014 Data]

--transfer[Model].[National Knife Crime 2014/2015 Data]

--transfer[Model].[National Knife Crime 2015/2016 Data]

--transfer[Model].[National Knife Crime 2016/2017 Data]

--transfer[Model].[National Knife Crime 2017/2018 Data]

--GO
