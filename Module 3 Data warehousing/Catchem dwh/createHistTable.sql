
CREATE TABLE weather_hist(
  city_id INT
, name VARCHAR(255)
, description VARCHAR(255)
, "TIMESTAMP" DATETIME);

CREATE INDEX idx_weather_hist_lookup ON weather_hist(city_id);

