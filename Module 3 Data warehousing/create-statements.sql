CREATE TABLE dimension_day
(
  year_number INT
, month_number INT
, day_of_year_number INT
, day_of_month_number INT
, day_of_week_number INT
, week_of_year_number INT
, day_name VARCHAR(30)
, month_name VARCHAR(30)
, quarter_number INT
, quarter_name VARCHAR(2)
, year_quarter_name VARCHAR(32)
, weekend_ind VARCHAR(1)
, DAYS_IN_MONTH_QTY INT
, DATE_SK INT
, DAY_DESC VARCHAR(100)
, WEEK_SK INT
, DAY_DATE DATETIME
, week_name VARCHAR(32)
, week_of_month_number INT
, week_of_month_name VARCHAR(100)
, MONTH_SK INT
, QUARTER_SK INT
, YEAR_SK INT
, YEAR_SORT_NUMBER VARCHAR(4)
, DAY_OF_WEEK_SORT_NAME VARCHAR(60)
, Season VARCHAR(100)
)
;

CREATE TABLE dimension_rain
(
  id BIGINT PRIMARY KEY
, rainType VARCHAR(31)
)
;CREATE INDEX idx_dim_rain_lookup ON dimension_rain(id, rainType)
;


CREATE TABLE weather_history
(
  city_id VARCHAR(255)
, description VARCHAR(31)
, "TIMESTAMP" DATETIME
, weather_id VARCHAR(100)
, name VARCHAR(400)
);

CREATE INDEX idx_weather_hist_lookup ON weather_history(city_id)
;

CREATE TABLE dbo.dimension_treasure
(
  treasure_id VARCHAR(255)
, terrain INT
, difficulty INT
, "size" INT
)
;

CREATE TABLE user_dimension
(
  Surrogate BIGINT PRIMARY KEY
, version INT
, date_from DATETIME
, date_to DATETIME
, u_id VARCHAR(255)
, first_name VARCHAR(255)
, last_name VARCHAR(255)
, street VARCHAR(255)
, number VARCHAR(255)
, city_city_id VARCHAR(255)
, logs_found INT
, number_treasures INT
, experience_level VARCHAR(100)
, dedicator VARCHAR(100)
)
;CREATE INDEX idx_user_dimension_lookup ON user_dimension(u_id)
;
CREATE INDEX idx_user_dimension_tk ON user_dimension(Surrogate)
;

  CREATE TABLE fact_treasure
(
  Log_id VARCHAR(255)
, User_id VARCHAR(255)
, Cte INT
, "Creation Date" DATETIME
, Duration INT
, Treasure_id VARCHAR(255)
, Day_id INT
, Weather_id BIGINT FOREIGN KEY REFERENCES dimension_rain(id)
);

CREATE INDEX idx_fact_treasure_lookup ON fact_treasure(Log_id, User_id)
;

