--Optimalisation dbo.treasure_log, ID is hexadecimal, padded with zeros, VARCHAR(255). Operator cost/& memory decrease by a ten fold
-- zoek verder uit hoe het precies zit van binary => binary + replace/modify de PK met nieuwe ID (vervang ID's overal!) modify, cascade? PK=> FK?
-- https://www.xaprb.com/blog/2009/02/12/5-ways-to-make-hexadecimal-identifiers-perform-better-on-mysql/
-- check also CITY ID + owner_ID + HUNTER ID + TREASURE ID (is similar)

-- indexing cf. last_name/ a lot of user with the same last name => will take long to query (consider the asc/desc order of columns?) there are 1000 unique last names. Or you can also use the first letter of the last name to do a skip scan
-- check the cyrlic names for helpdesk, should be query-able
-- a query can be optimized by removing the ASC or DESC when the table is already in the right order

SELECT id
FROM dbo.treasure_log;

SELECT CONVERT(binary(32), id, 1)
FROM dbo.treasure_log;

SELECT CONVERT(varchar(32), id, 2)
FROM dbo.treasure_log;

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

