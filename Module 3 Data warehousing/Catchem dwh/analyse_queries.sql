-- Vinden users de cache gemiddeld sneller in de regen?

SELECT	"gem duurtijd zoektocht geen regen" =	(SELECT AVG(duration) FROM dbo.fact_treasure fact WHERE fact.Weather_id = 999), 
		"gem duurtijd zoektocht regen" =		(SELECT AVG(duration) FROM dbo.fact_treasure fact1 WHERE fact1.Weather_id != 0 OR fact1.Weather_id !=  999);


--	Worden er gemiddeld minder caches gezocht op moeilijker terrein als het regent?

SELECT "caches op moeilijker terrein (regen)" = (SELECT COUNT(*) 
FROM dbo.treasure_found found 
JOIN dbo.fact_treasure fact ON found.treasure_id = fact.Treasure_id 
WHERE terrain > 2 AND fact.Weather_id != 999 AND fact.Weather_id != 0), 
"caches op moeilijker terrein (geen regen)" = (SELECT COUNT(*) 
FROM dbo.treasure_found found2
JOIN dbo.fact_treasure fact2 ON found2.treasure_id = fact2.Treasure_id
WHERE terrain > 2 AND fact2.Weather_id = 999)

-- Worden er in weekends meer moeilijkere caches gedaan? 

SELECT "moeilijkere caches in weekend (gem per dag)" = 
(SELECT COUNT(*)/2 FROM dbo.fact_treasure fact 
JOIN dbo.treasure_found found ON fact.Treasure_id = found.treasure_id 
JOIN dbo.dimension_day day ON day.DATE_SK = fact.Day_id
WHERE day.weekend_ind = 'Y' AND found.difficulty > 2), 
"moeilijkere caches in week (gem per dag)" = 
(SELECT COUNT(*)/5 FROM dbo.fact_treasure fact 
JOIN dbo.treasure_found found ON fact.Treasure_id = found.treasure_id 
JOIN dbo.dimension_day day ON day.DATE_SK = fact.Day_id
WHERE day.weekend_ind = 'N' AND found.difficulty > 2);
