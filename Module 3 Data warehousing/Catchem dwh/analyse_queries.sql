/*Vinden users de cache gemiddeld sneller in de regen?*/

SELECT	"gem duurtijd zoektocht geen regen" =	(SELECT AVG(duration) FROM dbo.fact_treasure fact WHERE fact.Weather_id = 999), 
		"gem duurtijd zoektocht regen" =		(SELECT AVG(duration) FROM dbo.fact_treasure fact1 WHERE fact1.Weather_id != 0 OR fact1.Weather_id !=  999);