
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- dbo.stage
	-- Getting the description of the stages belonging to a certain treasure
SELECT container_size, description, type, visibility
FROM dbo.stage 
WHERE id IN (SELECT stages_id
						FROM dbo.treasure_stages
						WHERE treasure_id =0x8000564D9C1F4A43A1C04E587093CFEC) and visibility = 1;

	-- to get quickly get the owner_id when asking the number of treasures tied to a treasure owner.
CREATE CLUSTERED INDEX clustered_index_treasure_stages   
    ON dbo.treasure_stages (treasure_id);
	
-- dbo.treasure
	-- Getting the number of treasures belonging to a certain owner_id
SELECT min(first_name) AS Voornaam, min(last_name) AS Achternaam, count(*) AS Aantal_treasures, min(dbo.user_table.id) AS User_id 
FROM dbo.treasure JOIN dbo.user_table ON (owner_id = dbo.user_table.id) GROUP BY dbo.user_table.id;

	-- verbeterede query
select first_name, last_name, count(*) AS 'number of treasures'
FROM dbo.user_table
JOIN dbo.treasure on (owner_id = dbo.user_table.id)
WHERE dbo.user_table.id IN (select owner_id
							FROM dbo.treasure
							WHERE id = 0x2741BFD7078F457A972505320E8CD0CD)
GROUP BY first_name, last_name; 

	-- Getting the owner_id more efficiently
CREATE NONCLUSTERED INDEX nclustered_owner_id   
    ON dbo.treasure (owner_id); 

	--Option 2: create index view 
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

	-- Better query for option 2?
select first_name, last_name, number
FROM number_treasure
WHERE id IN (select owner_id
			FROM dbo.treasure
			WHERE id = 0x2741BFD7078F457A972505320E8CD0CD); 

	-- Getting treasures based on location, difficulty, relief and number of stages

SELECT id, difficulty
FROM dbo.treasure
WHERE city_city_id = 0x1992A52F3BEC4181A1A165B12B28C8FD
and difficulty = 3;
 
SELECT id, terrain
FROM dbo.treasure
WHERE city_city_id = 0x1992A52F3BEC4181A1A165B12B28C8FD
and terrain = 1;
 
SELECT treasure_id, count(*)
FROM dbo.treasure_stages
JOIN dbo.treasure ON (id = treasure_id)
WHERE city_city_id =0x1992A52F3BEC4181A1A165B12B28C8FD
GROUP BY treasure_id
HAVING count(*) = 1;

SELECT treasure_id, terrain, difficulty, count(*) 'number of stages'
FROM dbo.treasure_stages
JOIN dbo.treasure ON (id = treasure_id)
WHERE city_city_id =0x1992A52F3BEC4181A1A165B12B28C8FD and difficulty = 1 and terrain = 3
GROUP BY treasure_id, terrain, difficulty
HAVING count(*) > 4;

SELECT t.id
FROM dbo.treasure AS t JOIN dbo.treasure_stages AS ts ON (t.id = ts.treasure_id)
WHERE city_city_id = 0x1992A52F3BEC4181A1A165B12B28C8FD
AND t.difficulty = 1 AND t.terrain = 3
GROUP BY t.id
HAVING COUNT(ts.stages_id) > 4;

	-- non-clustered index on city_city_id 

CREATE NONCLUSTERED INDEX nclustered_city_city_id   
    ON dbo.treasure (city_city_id); 

	-- non-clustered index on city_city_id including (the order of this index is the same as in the query)
CREATE NONCLUSTERED INDEX nclustered_city_city_id_incl  
    ON dbo.treasure (city_city_id)
	INCLUDE (terrain, difficulty); 
	
	--index view for the number of stages
	--Option 2: create index view
	 
SET NUMERIC_ROUNDABORT OFF;  
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,  
    QUOTED_IDENTIFIER, ANSI_NULLS ON;  

CREATE VIEW number_stages
WITH SCHEMABINDING  
AS  
		SELECT treasure_id, difficulty, terrain, city_city_id, count_BIG(*) 'number of stages'
		FROM dbo.treasure_stages
		JOIN dbo.treasure ON (id = treasure_id)
		GROUP BY treasure_id, difficulty, terrain, city_city_id;

CREATE UNIQUE CLUSTERED INDEX clustered_index_view_stages 
    ON number_stages (treasure_id);

CREATE NONCLUSTERED INDEX nclustered_city_id_incl  
    ON dbo.number_stages (city_city_id)
	INCLUDE (terrain, difficulty, "number of stages"); 

-- effect on write/operations
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

-- dbo.treasure_log

	--- getting the last posted logs of a certain treasure

SELECT TOP(100) description
FROM dbo.treasure_log 
WHERE treasure_id = 0xA08622C78B584E20829580504B7E1E01
ORDER BY log_time DESC;

CREATE NONCLUSTERED INDEX nclustered_treasure_id_log 
    ON dbo.treasure_log (treasure_id); 

CREATE NONCLUSTERED INDEX nclustered_treasure_id_log_incl
    ON dbo.treasure_log (treasure_id)
	INCLUDE (description); 
	
 -- creating a clustered index on log_time (to get the sort out of the query)

	CREATE UNIQUE CLUSTERED INDEX clustered_log_time 
    ON dbo.treasure_log (log_time, id);


 -- the helpdesk can moderate the posts

 -- dbo.user_table
 -- helpdesk can get lists of users
 select first_name, last_name
FROM dbo.user_table;


select first_name, last_name
FROM dbo.user_table
WHERE first_name = 'Yanis';

CREATE NONCLUSTERED INDEX nclustered_user_incl
    ON dbo.user_table (id)
	INCLUDE (first_name, last_name); 

 select *
FROM dbo.user_table;

