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

-- 

