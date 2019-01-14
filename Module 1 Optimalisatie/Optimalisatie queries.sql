---------------------------------------------------------------------------------------------------------
---------------------------------------- Optimalisatie Dossier ------------------------------------------
---------------------------------------------------------------------------------------------------------

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
	
use catchem; 

------------------------------------------ ID transformatie-----------------------------------------------

--test query

SELECT top(10) u.id , t.id, tl.id,ts.treasure_id,s.id
FROM dbo.user_table u
JOIN dbo.treasure t on (u.id=owner_id)
JOIN dbo.treasure_log tl on (tl.treasure_id = t.id)
JOIN dbo.treasure_stages ts on (t.id = ts.treasure_id)
JOIN dbo.stage s on (s.id = stages_id);

-- Voor de transformatie van de IDs van binary(255) naar binary(16) moet er rekening gehouden worden met de verscheidene PK-FK relaties

SELECT *
FROM sys.key_constraints; -- list of all PK

-- dbo.treasure_log: PK_treasure_log

ALTER TABLE dbo.treasure_log
DROP constraint "PK__treasure__3213E83F84E14D15";

ALTER TABLE dbo.treasure_log
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure_log
ADD constraint PK_treasure_log primary key(id);

-- to alter id_treasure, first remove FK on dbo.treasure_log, update both ID's and reinstate PK and FK.
ALTER TABLE dbo.treasure_log
DROP constraint "FK2civl72k0mvj6ox420p7lh8do";

ALTER TABLE dbo.treasure_log
ALTER COLUMN treasure_id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure_stages
DROP constraint "FK14l2mfyurovu79hsams09j1ki";

ALTER TABLE dbo.treasure_stages
ALTER COLUMN treasure_id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure
DROP constraint "PK__treasure__3213E83F6E1FAC76";

ALTER TABLE dbo.treasure
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure
ADD constraint PK_treasure primary key(id);

ALTER TABLE dbo.treasure_log
ADD constraint FK_treasure foreign key(treasure_id)
REFERENCES dbo.treasure (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE dbo.treasure_stages
ADD constraint FK_treasure_stages foreign key(treasure_id)
REFERENCES dbo.treasure (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

--  To change Hunter id, one must change the user_id, but also the two FK tied to dbo.treasure(owner and treasure)

ALTER TABLE dbo.treasure_log
DROP constraint "FKcrntp5tw71ba3uxeny1cs3k4m"; 

ALTER TABLE dbo.treasure_log
ALTER COLUMN hunter_id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure
DROP constraint "FKlbv4a3n4cu8fqq7uniywvq4pn";

ALTER TABLE dbo.treasure
ALTER COLUMN owner_id binary(16) NOT NULL; 

ALTER TABLE dbo.user_table
DROP constraint "PK__user_tab__3213E83F84155E88";

ALTER TABLE dbo.user_table
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.user_table
ADD constraint PK_user primary key(id);

ALTER TABLE dbo.treasure
ADD constraint FK_ownerid foreign key(owner_id)
REFERENCES dbo.user_table (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE dbo.treasure_log
ADD constraint FK_hunterid foreign key(hunter_id)
REFERENCES dbo.user_table (id);

-- dropping stage_id; wordt gerefereerd vanuit treasure_stages (verwijder eerst)

ALTER TABLE dbo.treasure_stages
DROP constraint "FKbbboas19x3eunaa89gh76vnk1";

ALTER TABLE dbo.treasure_stages
DROP constraint "UK_ih6wundmkl0wxp6h32elmddxk";

ALTER TABLE dbo.treasure_stages
ALTER COLUMN stages_id binary(16) NOT NULL; 

ALTER TABLE dbo.stage
DROP constraint "PK__stage__3213E83F200F2264";

ALTER TABLE dbo.stage
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.stage
ADD constraint PK_stage primary key(id);

ALTER TABLE dbo.treasure_stages
ADD constraint FK_stage foreign key(stages_id)
REFERENCES dbo.stage (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE dbo.treasure_stages
ADD constraint FK_treasurestage foreign key(treasure_id)
REFERENCES dbo.treasure (id);

ALTER TABLE dbo.treasure_stages
add CONSTRAINT UK_stages_id UNIQUE(stages_id)

--city_ID

ALTER TABLE dbo.treasure
ALTER COLUMN city_city_id binary(16) NOT NULL; 

ALTER TABLE dbo.user_table
ALTER COLUMN city_city_id binary(16) NOT NULL; 


------------------------------------------Indexering/Views-------------------------------------------

---------------- dbo.treasure------------------
-- (1) Query om het aantal treasures te zoeken horende bij een bepaalde user
select u.id, first_name, last_name, count(*) AS 'number of treasures'
From dbo.treasure
JOIN user_table u on (owner_id = u.id)
WHERE owner_id = 0x00012C54F065486CBF560329F2F0EB99
GROUP BY first_name, last_name, u.id; 

	-- (1) non-clustered index op owner_id

CREATE NONCLUSTERED INDEX nclustered_owner_id   
    ON dbo.treasure (owner_id); 
GO
	--Option 2: create index view 
DROP VIEW  number_treasure; 
GO

CREATE VIEW number_treasure 
WITH SCHEMABINDING AS  
	SELECT owner_id, first_name, last_name, COUNT_BIG(*) number
	FROM dbo.treasure JOIN dbo.user_table ON (owner_id = dbo.user_table.id) 
	GROUP BY owner_id, first_name, last_name;
GO

CREATE UNIQUE CLUSTERED INDEX clustered_index_view 
    ON number_treasure (owner_id);
GO

-- resulterende query te gebruiken om het aantal treasures te zoeken
SELECT *
FROM number_treasure 
WHERE owner_id = 0x00012C54F065486CBF560329F2F0EB99;

-- (2) query om teasures te zoeken op basis van location, difficulty, relief en number of stages

SELECT treasure_id, terrain, difficulty, city_city_id, count(*) 'number of stages'
FROM dbo.treasure_stages
JOIN dbo.treasure ON (id = treasure_id)
WHERE city_city_id =0x1992A52F3BEC4181A1A165B12B28C8FD and difficulty = 1 and terrain = 3
GROUP BY treasure_id, terrain, difficulty,city_city_id
HAVING count(*) > 4;

	-- non-clustered index on city_city_id 

CREATE NONCLUSTERED INDEX nclustered_city_city_id   
    ON dbo.treasure (city_city_id); 

	-- non-clustered index on city_city_id including (the order of this index is the same as in the query)
CREATE NONCLUSTERED INDEX nclustered_city_city_id_incl  
    ON dbo.treasure (city_city_id)
	INCLUDE (terrain, difficulty); 

DROP INDEX nclustered_city_city_id  
GO
	--index view for the number of stages
	--Option 2: create index view

CREATE VIEW number_stages
WITH SCHEMABINDING  
AS  
		SELECT city_city_id, treasure_id,  terrain,difficulty, count_BIG(*) 'number_of_stages'
		FROM dbo.treasure_stages
		JOIN dbo.treasure ON (id = treasure_id)
		GROUP BY treasure_id, difficulty, terrain, city_city_id;
GO
CREATE UNIQUE CLUSTERED INDEX clustered_index_view_stages 
    ON number_stages (treasure_id);

CREATE NONCLUSTERED INDEX nclustered_city_city_id_incl_vw 
    ON number_stages (city_city_id)
	INCLUDE (terrain, difficulty, number_of_stages); 

-- resulterende query om teasures te zoeken op basis van location, difficulty, relief en number of stages
SELECT *
FROM number_stages
WHERE city_city_id =0x1992A52F3BEC4181A1A165B12B28C8FD and difficulty = 1 and terrain = 3
AND number_of_stages > 4; 

-- effect on write/operations (nog even te testen)!
DECLARE @temptreasure TABLE (treasure_id binary(16))
DECLARE @tempstage TABLE (stages_id binary(16))
DECLARE @temp TABLE (treasure_id binary(16), stages_id binary(16))

	INSERT INTO dbo.stage 
	OUTPUT inserted.id INTO @temptreasure(treasure_id)
	VALUES (newid(), 1, 'test','34','135',  1,0,1 )

   	INSERT INTO dbo.treasure 
	OUTPUT inserted.id into @tempstage(stages_id)
	VALUES (newid(), 3, 1,0x3DBB2210E9D34B4FA9E52E13FC709D6C,0x00001CBFA8E546C1BAA621DE39F4E2D4)

	INSERT INTO @temp
	select s.stages_id, t.treasure_id
	from @tempstage as s 
	cross join @temptreasure as t ; 

	insert INTO dbo.treasure_stages (stages_id, treasure_id)
	select stages_id, treasure_id
	from @temp 
	
	select *
	FROM @temp  ;

-------------------- dbo.stage/dbo.treasure_stages--------------------------
-- Getting the description of the stages belonging to a certain treasure

SELECT top(10)  t.id treasure_id, ts.stages_id stage_id, u.owner_id,u.first_name 'owner name', u.last_name 'owner last name', u.number 'number of treasures',sts.difficulty, sts.terrain, s.description, s.visibility
FROM dbo.treasure t
JOIN number_treasure u on (u.owner_id=t.owner_id)
JOIN number_stages sts on (sts.treasure_id = t.id)
JOIN dbo.treasure_stages ts on (t.id = ts.treasure_id)
JOIN dbo.stage s on (s.id = stages_id)
where t.id =0x8000564D9C1F4A43A1C04E587093CFEC and visibility = 1;

-- index op de treasure ID van treasure_stages
CREATE CLUSTERED INDEX clustered_index_treasure_stages   
    ON dbo.treasure_stages (treasure_id);

------------------------------ dbo.user------------------------------------
 -- helpdesk can get lists of users
select first_name, last_name,  mail, number, street, city_city_id
FROM dbo.user_table
WHERE city_city_id = 0x3653D5C25DA14269B360EBA4CF2040C9
AND first_name = 'Eva';

   CREATE NONCLUSTERED INDEX nclustered_user_incl10
   ON dbo.user_table (city_city_id)
   INCLUDE (last_name, first_name, mail, number, street); 

   CREATE NONCLUSTERED INDEX nclustered_user_incl11
   ON dbo.user_table (city_city_id, last_name, first_name, mail, number, street); 

   drop index nclustered_user_incl10;

select last_name, first_name, mail, number, street, city_city_id
FROM dbo.user_table
WHERE first_name = 'Eva';

   CREATE NONCLUSTERED INDEX nclustered_user_incl12
   ON dbo.user_table (first_name)
   INCLUDE (last_name, mail, number, street, city_city_id); 


------------------------- dbo.treasure_log-----------------------------

--- Zoeken op de inhoud van de log

SELECT description
FROM dbo.treasure_log 
WHERE description like '%Maiores%'
ORDER BY log_time DESC;

--- index creëren

CREATE FULLTEXT CATALOG ft AS DEFAULT;

CREATE FULLTEXT INDEX ON dbo.treasure_log
(description language 0)
   KEY INDEX PK_treasure_log 
   with  
    CHANGE_TRACKING = AUTO, 
    STOPLIST=OFF;  
GO 

SELECT * 
FROM dbo.treasure_log
WHERE CONTAINS(description,'Maiores') ;
 
--- zoeken op de laatste logs (dit is wrch beter met partionering!)
SELECT TOP(100) description
FROM dbo.treasure_log 
WHERE treasure_id = 0xA08622C78B584E20829580504B7E1E01
ORDER BY log_time DESC;

CREATE NONCLUSTERED INDEX nclustered_treasure_id_log 
    ON dbo.treasure_log (treasure_id); 


	
 -- creating a clustered index on log_time (to get the sort out of the query)

	CREATE UNIQUE CLUSTERED INDEX clustered_log_time 
    ON dbo.treasure_log (log_time, id);

--- Partioning 

-- Partition treasure_log

USE [catchem]
GO
BEGIN TRANSACTION
CREATE PARTITION FUNCTION [partition_fun_treasure_log](datetime2(7)) AS RANGE LEFT FOR VALUES (N'2015-09-11T00:00:00', N'2016-03-11T00:00:00', N'2016-09-11T00:00:00', N'2017-03-11T00:00:00', N'2017-09-11T00:00:00', N'2018-03-11T00:00:00', N'2018-09-11T00:00:00', N'2019-03-11T00:00:00')

CREATE PARTITION SCHEME [partition_schemeµ_treasure_log] AS PARTITION [partition_fun_treasure_log] TO ([PARTITION1], [PARTITION2], [PARTITION3], [PARTITION4], [PARTITION5], [PARTITION6], [PARTITION7], [PARTITION8], [PARTITION9])

ALTER TABLE [dbo].[treasure_log] DROP CONSTRAINT [PK_treasure_log] WITH ( ONLINE = OFF )

SET ANSI_PADDING ON

ALTER TABLE [dbo].[treasure_log] ADD  CONSTRAINT [PK_treasure_log] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


CREATE CLUSTERED INDEX [ClusteredIndex_on_partition_schemeµ_treasure_log_636829971159361197] ON [dbo].[treasure_log]
(
	[log_time]
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [partition_schemeµ_treasure_log]([log_time])


DROP INDEX [ClusteredIndex_on_partition_schemeµ_treasure_log_636829971159361197] ON [dbo].[treasure_log]


COMMIT TRANSACTION

-- COMPRESSIE

SELECT DISTINCT
    s.name,
    t.name,
    i.name,
    i.type,
    i.index_id,
    p.partition_number,
    p.rows
FROM sys.tables t
LEFT JOIN sys.indexes i
ON t.object_id = i.object_id
JOIN sys.schemas s
ON t.schema_id = s.schema_id
LEFT JOIN sys.partitions p
ON i.index_id = p.index_id
    AND t.object_id = p.object_id
WHERE t.type = 'U' 
  AND p.data_compression_desc = 'NONE'
ORDER BY p.rows desc
 
 -- check de winst van row compression en page compression voor bepaalde tabel (hieronder treasure_log)

 EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'treasure_log', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'ROW'
 
EXEC sp_estimate_data_compression_savings 
    @schema_name = 'dbo', 
    @object_name = 'treasure_log', 
    @index_id = NULL, 
    @partition_number = NULL, 
    @data_compression = 'PAGE'

-- check hoeveel ruimte nog vrij is voor bepaalde files

	SELECT name,
    s.used / 128.0                  AS SpaceUsedInMB,
    size / 128.0 - s.used / 128.0   AS AvailableSpaceInMB
FROM sys.database_files
CROSS APPLY 
    (SELECT CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)) 
s(used)
WHERE FILEPROPERTY(name, 'SpaceUsed') IS NOT NULL;