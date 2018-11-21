-- Treasure, log en gebruikers aanmaken

-- PROBLEMS:
-- (?) how to automate this? the arguments are passed manually, this is not a simulation of the actual query that should be run 

-- Look into:
-- (!) Locking behaviour of inserts

--- Insert user 
INSERT INTO dbo.user_table(id, first_name, last_name, mail, number, street, city_city_id)
values (newid(), 'test', 'test', 'test' ,'000', 'test', 0x3DBB2210E9D34B4FA9E52E13FC709D6C ) ;-- work out CITY_ID


--To insert a treasure 
--the user must:
--		register terrain, difficulty (in dbo.treasure)
--		register stage(s): container_size, description, type (physical or virtual) and visibility (in dbo.stage)
--  the client app must:
--		add the coordinates of the stage (in dbo.stage)
-- the dba must:
--		sequence treasure ID 
--		sequence stage ID 
--		infer from the coordinates of the stage the city and country (in dbo.stage and dbo.treasure)
--		add sequence numbers for each added stage (in dbo.stage)
--		add owner_id from current user (in dbo.treasure)
-- 

INSERT INTO dbo.stage (id, container_size, description, latitude, longitude, sequence_number, type, visibility) -- how to automate sequence number? How are latitude and longitude passed?
values (newid(), 1, 'test','34','135', 6,0,1) ;

INSERT INTO dbo.treasure(id, difficulty, terrain, owner_id, city_city_id)
values (newid(), 3, 1,0xB3105970E96449C4A26602B0F2694FFB , 0x6234F00E0E994A6D8A7C5040FCA8CC1B ) ; -- how to sequence owner_id, refers to user_table (current.user?) city_id is referenced from l&l

INSERT into dbo.treasure_stages(treasure_id,stages_id)
values ( ?, ?); -- how to make connection? with scoope_identity? or with insert.output? 

-- insert logs
INSERT into dbo.treasure_log(id, description, log_time, log_type, session_start, hunter_id, treasure_id) -- argument to session_start is wrong, how to pass this argument? hunter_id should current user. How to pass treasure_id?
values (newid(), 'test', SYSDATETIME(), 1, SYSDATETIME(), 0x9EA59528D0C141F78DB9BDE546A576EF, 0x56A0B2C1931A4E16A94AD0B0C1B746F8); 



 