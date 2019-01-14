
-- creating a snapshot of catchem
CREATE DATABASE Catchem_dbss001 ON  
( NAME = catchem, FILENAME =   
'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER2017\MSSQL\DATA\catchemsnap.ss' )  
AS SNAPSHOT OF catchem;  
GO  
-- reverting catchem 

USE master;  
RESTORE DATABASE catchem FROM DATABASE_SNAPSHOT = 'Catchem_dbss001';  
GO

-- All ID's are stored as binary(255), meaning that the binary value takes up 255 bytes.
-- This inflates the computation time (18s), I/O cost= 292.417 and CPU cost =1.97 
-- Solution is to store this ID as a binary, legnth 16byte. Why 16? The identifier was is an hexadecimal UUID which need 16 byte to store
-- The computation time is reduced to 15s, I/O cost = 0 and CPU cost = 0.179
-- This is done for all identifiers
-- Remark: one possible problem with storing it binary is that different implementation may change the order of the bytes when storing. So you might also store it as a char.

use catchem; 

-- Conversion
-- For the conversion, we need to take into account the different PK and FK relationships

SELECT *
FROM sys.key_constraints; -- list of all PK

-- dbo.treasure_log: PK_treasure_log (no reference to other tables)

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


select *
FROM dbo.user_table; 