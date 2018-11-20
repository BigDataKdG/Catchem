-- Treasure, log en gebruikers aanmaken

-- (?) Locking behaviour of inserts, 

--To insert a treasure 
--the user must:
--		register terrain, difficulty (in dbo.treasure)
--		register stage(s): container_size, description, type (physical or virtual) and visibility (in dbo.stage)
--  the client app must:
--		add the coordinates of the stage (in dbo.stage)
-- the dba must:
--		sequence treasure ID (uuid?)
--		sequence treasure_stage ID 
--		infer from the coordinates of the stage the city and country (in dbo.stage and dbo.treasure)
--		add sequence numbers for each added stage (in dbo.stage)
--		add owner_id from current user (in dbo.treasure)
-- 


INSERT INTO dbo.treasure(id, difficulty, terrain, owner_id, city_city_id)
values (newid(),3,1,USER_NAME(id), 0x6234F00E0E994A6D8A7C5040FCA8CC1B); 

INSERT INTO dbo.treasure_stages(treasure_id, stages_id)
values (SCOPE_IDENTITY() as [scope_identity] ,0x6234F00E0E994A6D8A7C5040FCA8CC1B ); 

select SCOPE_IDENTITY();

select newid();

select IDENT_CURRENT(dbo.treasure);

INSERT INTO dbo.treasure
SELECT id FROM dbo.user_table
WHERE username(dbo.user_table.id);



DECLARE @myid uniqueidentifier  
SET @myid = NEWID()  
PRINT 'Value of @myid is: '+ CONVERT(varchar(255), @myid


select *
FROM dbo.stage;

select *
FROM dbo.user_table;

select *
FROM dbo.treasure;

select *
FROM dbo.treasure
WHERE ID =0x00003E2CB14041B197F00033C097E070;

select *
FROM dbo.treasure_stages;

-- Treasure met verschillende stages


-- Logs aanmaken

-- Registratie gebruiker 

 