-- Optimalisatie 

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
	
-- dbo.treasure
-- (1) Query om het aantal treasures te zoeken horende bij 
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

-- dbo.stage/dbo.treasure_stages
-- Getting the description of the stages belonging to a certain treasure

SELECT container_size, description, type, visibility
FROM dbo.stage 
WHERE id IN (SELECT stages_id
						FROM dbo.treasure_stages
						WHERE treasure_id =0x8000564D9C1F4A43A1C04E587093CFEC) and visibility = 1;

-- index op de treasure ID van treasure_stages
CREATE CLUSTERED INDEX clustered_index_treasure_stages   
    ON dbo.treasure_stages (treasure_id);

	select *
	FROM dbo.stage;

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
SELECT first_name, last_name
FROM dbo.user_table;

select last_name, first_name id
FROM dbo.user_table
WITH (index(nclustered_user_incl3))
WHERE first_name = 'EVA';

select last_name, first_name id
FROM dbo.user_table
WHERE first_name = 'EVA';

select last_name, first_name,id
FROM dbo.user_table
WHERE city_city_id = 0x1992A52F3BEC4181A1A165B12B28C8FD
AND first_name = 'Eva';

select last_name, first_name,id
FROM dbo.user_table
WHERE city_city_id = 0x1992A52F3BEC4181A1A165B12B28C8FD
AND first_name = 'Eva';


-- slow ndex
CREATE NONCLUSTERED INDEX nclustered_user_incl
    ON dbo.user_table (id)
	INCLUDE (first_name, last_name); 
-- best
CREATE NONCLUSTERED INDEX nclustered_user_incl3
    ON dbo.user_table (first_name)
	INCLUDE (last_name); 
-- equivalent to best?
CREATE NONCLUSTERED INDEX nclustered_user_incl2
   ON dbo.user_table (first_name, last_name); 

   CREATE NONCLUSTERED INDEX nclustered_user_incl4
   ON dbo.user_table (last_name, first_name); 

   CREATE NONCLUSTERED INDEX nclustered_user_incl5
   ON dbo.user_table (city_city_id, last_name, first_name); 

   CREATE NONCLUSTERED INDEX nclustered_user_incl6
   ON dbo.user_table (city_city_id)
   INCLUDE (first_name, last_name); 

   CREATE NONCLUSTERED INDEX nclustered_user_incl7
   ON dbo.user_table ( first_name,city_city_id, last_name); 


 select first_name, count(*) count
FROM dbo.user_table
group by first_name
oRDER BY count desc;

select *
FROM dbo.user_table; 

--- Partioning 
