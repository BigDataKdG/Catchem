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
