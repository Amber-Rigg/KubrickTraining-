use crime
go

-- Primary Key
-- Crime Data table

ALTER TABLE [Model].[Crime Data]
ALTER COLUMN [Crime ID] INT NOT NULL

ALTER TABLE [Model].[Crime Data]
ADD PRIMARY KEY ([Crime ID])

-- Police Force Data

ALTER TABLE [Model].[Police Force Data]
ALTER COLUMN [Police Force ID] INT NOT NULL

ALTER TABLE [Model].[Outcome Type Data]
ADD PRIMARY KEY ([Outcome ID])

-- Outcome Type Data

ALTER TABLE [Model].[Outcome Type Data]
ALTER COLUMN [Outcome ID] INT NOT NULL

ALTER TABLE [Model].[Outcome Type Data]
ADD PRIMARY KEY ([Outcome ID])

-- Crime Type Data

ALTER TABLE [Model].[Crime Type Data]
ALTER COLUMN [Crime Type ID] INT NOT NULL

ALTER TABLE [Model].[Crime Type Data]
ADD PRIMARY KEY ([Crime Type ID])

-- Felony Misdemeanror

ALTER TABLE [Model].[Felony/Misdemeanor Data]
ALTER COLUMN [Felony/Misdemeanor ID] INT NOT NULL

ALTER TABLE [Model].[Felony/Misdemeanor Data]
ADD PRIMARY KEY ([Felony/Misdemeanor ID])

-- Crime Category Data

ALTER TABLE [Model].[Crime Category Data]
ALTER COLUMN [Crime Category ID] INT NOT NULL

ALTER TABLE [Model].[Crime Category Data]
ADD PRIMARY KEY ([Crime Category ID])

-- Victim/Victimless Crime

ALTER TABLE [Model].[Victim/Victimless Data]
ALTER COLUMN [Victim/Victimless ID] INT NOT NULL

ALTER TABLE [Model].[Victim/Victimless Data]
ADD PRIMARY KEY ([Victim/Victimless ID])

-- Date Data

ALTER TABLE [Model].[Date Data]
ALTER COLUMN [Date] date NOT NULL

ALTER TABLE [Model].[Date Data]
ADD PRIMARY KEY ([Date])

--Geogrpahy Data

ALTER TABLE [Model].[Geography Data]
ALTER COLUMN [LSOA Code] varchar(9) NOT NULL

ALTER TABLE [Model].[Geography Data]
ADD PRIMARY KEY ([LSOA Code])

-- Local Authority District

ALTER TABLE [Model].[Local Authority District]
ALTER COLUMN [Local Authority District ID] INT NOT NULL

ALTER TABLE [Model].[Local Authority District]
ADD PRIMARY KEY ([Local Authority District ID])

-- Region Data

ALTER TABLE [Model].[Region Data]
ALTER COLUMN [Police Force Area ID] INT NOT NULL

ALTER TABLE [Model].[Region Data]
ADD PRIMARY KEY ([Police Force Area ID])

-- Financial Year

ALTER TABLE Model.[Financial Year LOOKUP]
ADD PRIMARY KEY ([Financial Year])

-- Foreign Key

ALTER TABLE [Model].[Crime Data]
ADD FOREIGN KEY ([Date])
REFERENCES [Model].[Date Data] ([Date])

ALTER TABLE [Model].[Crime Data]
ALTER COLUMN [Police ID] INT

ALTER TABLE [Model].[Crime Data]
ADD FOREIGN KEY ([Police ID])
REFERENCES [Model].[Police Force Data] ([Police ID])

ALTER TABLE [Model].[Crime Data]
ALTER COLUMN [Outcome ID] INT

ALTER TABLE [Model].[Crime Data]
ADD FOREIGN KEY ([Outcome ID])
REFERENCES [Model].[Outcome Type Data] ([Outcome ID])

ALTER TABLE [Model].[Crime Type Data]
ALTER COLUMN [Crime Category ID] INT

ALTER TABLE [Model].[Crime Type Data]
ADD FOREIGN KEY ([Crime Category ID])
REFERENCES [Model].[Crime Category Data] ([Crime Category ID])

ALTER TABLE [Model].[Crime Type Data]
ALTER COLUMN [Felony/Misdemeanor ID] INT

ALTER TABLE [Model].[Crime Type Data]
ADD FOREIGN KEY ([Felony/Misdemeanor ID])
REFERENCES [Model].[Felony/Misdemeanor Data]([Felony/Misdemeanor ID])

ALTER TABLE [Model].[Crime Type Data]
ALTER COLUMN [Victim/Victimless ID] INT

ALTER TABLE [Model].[Crime Type Data]
ADD FOREIGN KEY ([Victim/Victimless ID])
REFERENCES [Model].[Victim/Victimless Data]([Victim/Victimless ID])

alter table [Model].[Crime Data] with nocheck
add foreign key ([LSOA Code])
References [Model].[Geography Data]([LSOA Code])

ALTER TABLE [Model].[Population Data]
ADD FOREIGN KEY ([LSOA Code])
REFERENCES [Model].[Geography Data]([LSOA Code])

ALTER TABLE [Model].[Knife Crime Country Data]
ADD FOREIGN KEY ([Police Force Area ID])
REFERENCES [Model].[Region Data]([Police Force Area ID])

ALTER TABLE [Model].[Knife Crime London Data]
ADD FOREIGN KEY ([Local Authority District ID ])
REFERENCES [Model].[Local Authority District]([Local Authority District ID])

ALTER TABLE [Model].[Geography Data] with nocheck
ADD FOREIGN KEY ([Local Authority District ID])
REFERENCES [Model].[Local Authority District]([Local Authority District ID])

alter table [Model].[Date DIMENSION] with nocheck
add foreign key ([Financial Year])
References Model.[Financial Year LOOKUP]([Financial Year]) 

alter table [Model].[Knife Crime Country DIMENSION] with nocheck
add foreign key ([Financial Year])
References Model.[Financial Year LOOKUP]([Financial Year]) 

alter table [Model].[Knife Crime London DIMENSION] with nocheck
add foreign key ([Financial Year])
References Model.[Financial Year LOOKUP]([Financial Year]) 

alter table [Model].[Population Data DIMENSION] with nocheck
add foreign key ([Financial Year])
References Model.[Financial Year LOOKUP]([Financial Year]) 
