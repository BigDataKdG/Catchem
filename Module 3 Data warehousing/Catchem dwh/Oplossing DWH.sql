/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Log_id]
      ,[User_id]

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


	select *
	FROM dbo.fact_treasure8;

		select *
	FROM dbo.user_dim;

select u.id, first_name, last_name, street, number, city_city_id, t.id, count(*) logs_found
FROM dbo.user_table u
LEFT JOIN dbo.treasure_log t ON u.id = t.hunter_id
GROUP by u.id, first_name, last_name, street, number, city_city_id, t.id
order by t.id asc;

select u.id, first_name, last_name, street, number, city_city_id, t.id
FROM dbo.user_table u
LEFT JOIN dbo.treasure_log t ON u.id = t.hunter_id
order by t.id;

select u.id, first_name, last_name, street, number, city_city_id, t.id, count(*) logs_found
FROM dbo.user_table u
LEFT JOIN dbo.treasure_log t ON u.id = t.hunter_id
WHERE u.id = 0x070BD1E3CBCE4DD099DD04431BA40ABE
GROUP by u.id, first_name, last_name, street, number, city_city_id, t.id
; 


0x070BD1E3CBCE4DD099DD04431BA40ABE
0x0EA41CD5ED6F4C81837D9D1CEF8CCB2D

select *
FROM dbo.user_table
WHERE ID = 0x070BD1E3CBCE4DD099DD04431BA40ABE; 




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
												, "Dedicator" = CASE
																	WHEN hunter_id IN (SELECT owner_id
																					   FROM treasure) THEN 'Yes'
																	ELSE 'No'
																END
												
FROM treasure_log tl
JOIN user_table u ON u.id = tl.hunter_id
WHERE log_type = 2;
