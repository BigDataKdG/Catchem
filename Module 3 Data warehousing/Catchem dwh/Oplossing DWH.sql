
  -- Effect van datumparameters
	-- effect van dagen van de week
  select day_name, count(*) 'number of treasures'
  FROM dbo.fact_treasure8
  JOIN dbo.season on day_id = DATE_SK
  GROUP BY day_name;


  	-- effect van weken 
  select week_of_year_number, count(*) 'number of treasures'
  FROM dbo.fact_treasure8
  JOIN dbo.season on day_id = DATE_SK
  GROUP BY week_of_year_number
  ORDER BY 1;

  	-- effect van maanden 
  select month_number, month_name, count(*) 'number of treasures'
  FROM dbo.fact_treasure8
  JOIN dbo.season on day_id = DATE_SK
  GROUP BY month_name, month_number
  ORDER BY 1;

  	-- effect van seizoenen
  select seasonString, count(*) 'number of treasures'
  FROM dbo.fact_treasure8
  JOIN dbo.season on day_id = DATE_SK
  GROUP BY seasonString;

 -- Effect van type user

	select experience_level, count(*) 'number of treasures'
	FROM dbo.fact_treasure8 t
	JOIN dbo.user_dim ON t.User_id = u_id
	GROUP BY experience_level; 

 -- Zoeken beginnende users gemiddeld naar grotere caches 
 -- werkt nog niet!
	select experience_level, cte, avg(size) 'number of treasures'
	FROM dbo.fact_treasure8 f
	JOIN dbo.treasure_found t on t.treasure_id = f.Treasure_id
	JOIN dbo.user_dim on u_id = User_id
	group by  experience_level;

 -- Worden er gemiddeld minder caches gezocht op moeilijker terrein als het regent?

	select terrain, rain, count(*)
	FROM dbo.fact_treasure8 f
	JOIN dbo.treasure_found t on f.treasure_id=t.treasure_id
	JOIN dbo.weather_hist on wheater_id= 



	select top(100) *
	FROM dbo.treasure_found; 
	select top(100) *
	FROM dbo.fact_treasure8; 
	select top(100) *
	FROM dbo.user_dim; 
	select top(100) *
	FROM dbo.dim_rain; 
	select top(100) *
	FROM dbo.weather_hist; 




	select *
	FROM dbo.fact_treasure8;

		select *
	FROM dbo.user_dim;


SELECT TOP 5000 u.id 'user_id', u.first_name, u.last_name, u.street, log_time, "ExperienceLevel" = CASE 
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) = NULL THEN 'Newbie'
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) > 0 AND (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) <= 3 THEN 'Amature'
																		WHEN (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) > 3 AND (SELECT COUNT(hunter_id)
																			 FROM treasure_log tl1
																			 WHERE tl.hunter_id = tl1.hunter_id AND tl1.log_time <= tl.log_time) <= 10 THEN 'Regular'
																		ELSE 'Expert' END											
FROM treasure_log tl
JOIN user_table u ON u.id = tl.hunter_id
WHERE log_type = 2
order by user_id;

select u.id, u.first_name, log_time
FROM treasure_log tl
JOIN user_table u ON u.id = tl.hunter_id
WHERE log_type = 2
ORDER BY u.id; 


