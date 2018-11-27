-- Onderstaande query geeft alle treasure id's terug die zich in een bepaalde omgeving (stad) bevinden, met een gegeven moeilijkheidsgraad en terrein. Daarna worden alle id's die gelijk zijn aan elkaar samen genomen, en wordt er geteld hoeveel stages ze hebben. In deze JOIN tabel zijn de treasure id's namelijk niet uniek, maar wel de stage id's. Door de treasure id's samen te nemen en een count te doen op de stage id's, krijg je het aantal stages per treasure. Hierop kan je dan gaan filteren door te zeggen dat dit groter, kleiner, of gelijk aan een bepaald aantal stages moet zijn. 

SELECT t.id
FROM dbo.treasure AS t JOIN dbo.treasure_stages AS ts ON (t.id = ts.treasure_id)
WHERE city_city_id = 0xC6C178B1391C4DD2947E7A45B93A1C350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
AND t.difficulty = 1 AND t.terrain = 3
GROUP BY t.id
HAVING COUNT(ts.stages_id) > 4;

-- Onderstaande query is een hulpquery die wat visueler weergeeft hoe de JOIN er eigenlijk uitziet voor de GROUP BY en de WHERE
-- Hier zie je dus duidelijk dat enkel de stage id's uniek zijn

SELECT *
FROM dbo.treasure AS t JOIN dbo.treasure_stages AS ts ON (t.id = ts.treasure_id);

-- update certain column from logs 

UPDATE dbo.treasure_log
SET log_type = 1
WHERE id = 0x00000E5798D748478FA1FD1775B2C0130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

select top(10) * from dbo.treasure_log WHERE description LIKE '%velit%';

-- De helpdesk kan ook lijsten opvragen van gebruikers
-- De belangrijke vraag is wel HOE ze dit precies mogen doen. We kunnen wel testen schrijven, maar er is een groot verschil of bv een wildcard mag gebruikt worden of niet 


select *
FROM dbo.user_table;

select first_name
FROM dbo.user_table;

select last_name
FROM dbo.user_table;

select first_name, last_name
FROM dbo.user_table;

select first_name, last_name, mail, number, street
FROM dbo.user_table;


-- using wildcards at the beginning make for very inefficient queries as it disables index usage 
-- Think about how names should be searched; full wildcard is always inefficient, perhaps use n.gram tables?

select last_name
FROM dbo.user_table
WHERE last_name LIKE '%for%';

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

--INSERT into dbo.treasure_stages(treasure_id,stages_id)
--values ( ?, ?); -- how to make connection? with scoope_identity? or with insert.output? 
-- do you do this with a trigger?
-- or does the client app indicate which stages belong to a treasure?
-- sequencing wise: is a cross-reference table faster compared to including it into the table?


-- insert logs
INSERT into dbo.treasure_log(id, description, log_time, log_type, session_start, hunter_id, treasure_id) -- argument to session_start is wrong, how to pass this argument? hunter_id should current user. How to pass treasure_id?
values (newid(), 'test', SYSDATETIME(), 1, SYSDATETIME(), 0x9EA59528D0C141F78DB9BDE546A576EF, 0x56A0B2C1931A4E16A94AD0B0C1B746F8); 


select *
From dbo.treasure_stages;

select *
From dbo.treasure;

select *
From dbo.stage;
 
 -- LAATSTE X AANTAL LOG BERICHTEN OPVRAGEN 

SELECT TOP(10) *
FROM dbo.treasure_log 
WHERE treasure_id = 0x3180AC1897A047ED92D885AB589175540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ORDER BY log_time DESC;


-- BESCHRIJVING OPVRAGEN

SELECT description 
FROM dbo.treasure_log
WHERE treasure_id = 0x3180AC1897A047ED92D885AB589175540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

-- Gegevens van gebruiker en aantal beheerde treasures

SELECT min(first_name) AS Voornaam, min(last_name) AS Achternaam, count(*) AS Aantal_treasures, min(dbo.user_table.id) AS User_id 
FROM dbo.treasure JOIN dbo.user_table ON (owner_id = dbo.user_table.id) GROUP BY dbo.user_table.id;

-- Details van stage waar zichtbaarheid = x (possible values zijn 0, 1 en 2)

SELECT *
FROM dbo.stage
WHERE visibility = 2;

