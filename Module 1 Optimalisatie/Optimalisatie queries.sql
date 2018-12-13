
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT container_size, description, type, visibility
FROM dbo.stage 
WHERE id IN (SELECT stages_id
						FROM dbo.treasure_stages
						WHERE treasure_id =0x8000564D9C1F4A43A1C04E587093CFEC) and visibility = 1;

-- works for getting all the stages tied to a treasure
CREATE CLUSTERED INDEX clustered_index_treasure_stages   
    ON dbo.treasure_stages (treasure_id);
	
SELECT TOP(10) *
FROM dbo.treasure_log 
WHERE treasure_id = 0x3180AC1897A047ED92D885AB589175540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ORDER BY log_time DESC;

SELECT description 
FROM dbo.treasure_log
WHERE treasure_id = 0x3180AC1897A047ED92D885AB589175540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;

-- Gegevens van gebruiker en aantal beheerde treasures
-- dit klopt niet volledig: het is gegeven een specieke user die aan een specifieke treasure hangt
SELECT min(first_name) AS Voornaam, min(last_name) AS Achternaam, count(*) AS Aantal_treasures, min(dbo.user_table.id) AS User_id 
FROM dbo.treasure JOIN dbo.user_table ON (owner_id = dbo.user_table.id) GROUP BY dbo.user_table.id;

select first_name, last_name, count(*) AS 'number of treasures'
FROM dbo.user_table
JOIN dbo.treasure on (owner_id = dbo.user_table.id)
WHERE dbo.user_table.id IN (select owner_id
							FROM dbo.treasure
							WHERE id = 0x2741BFD7078F457A972505320E8CD0CD)
GROUP BY first_name, last_name; 

CREATE NONCLUSTERED INDEX nclustered_owner_id   
    ON dbo.treasure (owner_id); 

--create index view 
SET NUMERIC_ROUNDABORT OFF;  
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,  
    QUOTED_IDENTIFIER, ANSI_NULLS ON;  

CREATE VIEW number_treasure
WITH SCHEMABINDING  
AS  
	SELECT dbo.user_table.id, first_name, last_name, COUNT_BIG(*) number
	FROM dbo.treasure JOIN dbo.user_table ON (owner_id = dbo.user_table.id) 
	GROUP BY dbo.user_table.id, first_name, last_name;

CREATE UNIQUE CLUSTERED INDEX clustered_index_view 
    ON number_treasure (id);

select first_name, last_name, number
FROM number_treasure
WHERE id IN (select owner_id
			FROM dbo.treasure
			WHERE id = 0x2741BFD7078F457A972505320E8CD0CD); 



select id, first_name, last_name, number
FROM number_treasure
WHERE ID = 0x00012C54F065486CBF560329F2F0EB99;


select owner_id
			FROM dbo.treasure
			WHERE id = 0x00003E2CB14041B197F00033C097E070; 

select first_name, last_name, number
FROM dbo.number_treasure
WHERE id = 0x000DA8C4C4884970A45D4E9CE593101F; 


select *
FROM dbo.number_treasure
; 
  
WHERE id = 0x00003E2CB14041B197F00033C097E070





   select *
   from dbo.treasure_log; 

   select *
   from dbo.treasure
   WHERE owner_id = 0x00012C54F065486CBF560329F2F0EB99; 

     select *
   from dbo.treasure_stages; 

        select *
   from dbo.stage;  

      select *
   from dbo.user_table; 