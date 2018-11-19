--Optimalisation dbo.treasure_log, ID is hexadecimal, padded with zeros, VARCHAR(255).

-- zoek verder uit hoe het precies zit van binary => binary + replace/modify de PK met nieuwe ID (vervang ID's overal!) modify, cascade? PK=> FK?
-- https://www.xaprb.com/blog/2009/02/12/5-ways-to-make-hexadecimal-identifiers-perform-better-on-mysql/
-- check also CITY ID + owner_ID + HUNTER ID + TREASURE ID (is similar)

--As Adam mentioned from the MSDN quote, UUIDs are 128-bit values. This means that they take 16 bytes of RAM to hold a value. 
--A text representation will take 32 bytes (two bytes for each single byte), plus the 4 hyphens, plus the two brackets if you want to 
--include those; this amounts to 38 bytes.Just keep in mind that if you are exposing UUIDs to users of your software, they may provide 
--the UUID with or without the brackets. If you're storing the value anywhere, it's best to store it as the 16-byte binary representation. 
--If you are interoperating with other UUID implementations, you may want to use the basic text format for interoperability, since different 
--implementations do different things to the order of bytes when storing a binary UUID value.


-- All ID's are stored as binary(255), meaning that the binary value takes up 255 bytes.
-- This inflates the computation time (18s), I/O cost= 292.417 and CPU cost =1.97 
-- Solution is to store this ID as a binary, legnth 16byte. Why 16? The identifier was most probably created as an hexadecimal UUID which need 16 byte to store
-- The computation time is reduced to 15s, I/O cost = 0 and CPU cost = 0.179
-- This is done for all identifiers: id treasure_log, hunter_id, treasure_id.
-- Remark: one possible problem with storing it binary is that different implementation may change the order of the bytes when storing. So you might also store it as a char.

-- Diagnostic results
SELECT id
FROM dbo.treasure_log;

SELECT CONVERT(binary(16), id, 2)
FROM dbo.treasure_log;

-- Conversion
-- For the conversion, we need to take into account the different PK and FK relationships

-- dbo.treasure_log: PK_treasure_log
SELECT *
FROM sys.key_constraints;

ALTER TABLE dbo.treasure_log
DROP constraint "PK__treasure__3213E83F84E14D15";

ALTER TABLE dbo.treasure_log
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure_log
ADD constraint PK_treasure_log primary key(id);

select *
FROM dbo.treasure_log;

-- to alter id_treasure, first remove FK on dbo.treasure_log, update both ID's and reinstate PK and FK.
ALTER TABLE dbo.treasure_log
DROP constraint "FK2civl72k0mvj6ox420p7lh8do";

ALTER TABLE dbo.treasure_log
ALTER COLUMN treasure_id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure
DROP constraint "PK__treasure__3213E83F6E1FAC76";

ALTER TABLE dbo.treasure
ALTER COLUMN id binary(16) NOT NULL; 

ALTER TABLE dbo.treasure
ADD constraint PK_treasure primary key(id);

ALTER TABLE dbo.treasure_log
ADD constraint FK_treasure foreign key(treasure_id)
REFERENCES dbo.treasure (id);

select *
FROM dbo.treasure_log;

--  To change Hunter id, one must change the user_id, but also the two FK tied to dbo.treasure(owner and treasure)

ALTER TABLE dbo.treasure_log
DROP constraint "FKcrntp5tw71ba3uxeny1cs3k4m"; -- hunter ID

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
	REFERENCES dbo.user_table (id);

ALTER TABLE dbo.treasure_log
ADD constraint FK_hunterid foreign key(hunter_id)
REFERENCES dbo.user_table (id);

-- dropping stage_id; wordt gerefereerd vanuit treasure_stages (verwijder eerst)

select *
FROM dbo.treasure_stages;

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
REFERENCES dbo.stage (id);

ALTER TABLE dbo.treasure_stages
add CONSTRAINT UK_stages_id UNIQUE(stages_id)

--city_ID

ALTER TABLE dbo.treasure
ALTER COLUMN city_city_id binary(16) NOT NULL; 



select *
from dbo.treasure_log;

select *
from dbo.treasure_stages;

select *
from dbo.user_table;


select *
from dbo.treasure_log;



ALTER TABLE dbo.treasure_log
ADD constraint FK_hunter foreign key(hunter_id)
REFERENCES dbo.user_table (id);



select *
FROM dbo.stage;



ALTER TABLE dbo.stage
ALTER COLUMN id binary(16) NOT NULL; 


--dbo.treasure_stages
select *
FROM dbo.treasure_stages;

ALTER TABLE dbo.treasure_stages
DROP constraint "FK14l2mfyurovu79hsams09j1ki";

ALTER TABLE dbo.treasure_stages
ALTER COLUMN treasure_id binary(16) NOT NULL; 

-- first you must delete the dbo.treasure





select*
FROM dbo.treasure;

ALTER TABLE dbo.treasure
ALTER COLUMN id binary(16) NOT NULL; 


ALTER TABLE dbo.treasure
ADD constraint FK_treasure foreign key(treasure_id)
REFERENCES dbo.treasure (id);


ALTER TABLE dbo.treasure_stages
ADD constraint FK_treasure foreign key(treasure_id)
REFERENCES dbo.treasure (id);













select *
from dbo.stage;

select *
from dbo.treasure;

select *
from dbo.treasure_log;

select *
from dbo.treasure_stages;

select * 
from dbo.user_table;

select DISTINCT last_name
from dbo.user_table;

select DISTINCT first_name
from dbo.user_table;

select *
FROM dbo.stage;

select * from treasure;

alter table treasure add amount_of_stages int;
UPDATE treasure SET amount_of_stages = (select count(*) from treasure JOIN treasure_stages ON (treasure.id=treasure_stages.treasure_id) group by dbo.treasure_stages.treasure_id having COUNT(*)=9);

select count(*) from treasure JOIN treasure_stages ON (treasure.id=treasure_stages.treasure_id) group by dbo.treasure_stages.treasure_id;

select count(*) from treasure JOIN treasure_stages ON (treasure.id=treasure_stages.treasure_id) group by dbo.treasure_stages.treasure_id having COUNT(*)=9;

DECLARE @difficulty INT
Select *
FROM dbo.treasure
WHERE difficulty = @difficulty;

--BALLZ
