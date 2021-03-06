
-- Dit eerste deel is volgens mij gewoon dingen aanzetten en opzoeken
use [catchem]
go

SET QUOTED_IDENTIFIER ON
go

SET ARITHABORT ON
go

SET CONCAT_NULL_YIELDS_NULL ON
go

SET ANSI_NULLS ON
go

SET ANSI_PADDING ON
go

SET ANSI_WARNINGS ON
go

SET NUMERIC_ROUNDABORT OFF
go

CREATE VIEW [dbo].[_dta_mv_1] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[treasure].[id] as _col_1,  [dbo].[treasure].[difficulty] as _col_2,  [dbo].[treasure].[terrain] as _col_3,  [dbo].[treasure].[city_city_id] as _col_4,  [dbo].[treasure].[owner_id] as _col_5,  [dbo].[treasure_stages].[treasure_id] as _col_6,  [dbo].[treasure_stages].[stages_id] as _col_7 FROM  [dbo].[treasure],  [dbo].[treasure_stages]   WHERE  [dbo].[treasure].[id] = [dbo].[treasure_stages].[treasure_id]  

go

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

go

CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_1_c_5_1717581157__K7] ON [dbo].[_dta_mv_1]
(
	[_col_7] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET QUOTED_IDENTIFIER ON
go

SET ARITHABORT ON
go

SET CONCAT_NULL_YIELDS_NULL ON
go

SET ANSI_NULLS ON
go

SET ANSI_PADDING ON
go

SET ANSI_WARNINGS ON
go

SET NUMERIC_ROUNDABORT OFF
go

CREATE VIEW [dbo].[_dta_mv_8] WITH SCHEMABINDING
 AS 
SELECT  [dbo].[treasure].[city_city_id] as _col_1,  [dbo].[treasure].[difficulty] as _col_2,  [dbo].[treasure].[terrain] as _col_3,  [dbo].[treasure].[id] as _col_4,  count_big(*) as _col_5 FROM  [dbo].[treasure],  [dbo].[treasure_stages]   WHERE  [dbo].[treasure].[id] = [dbo].[treasure_stages].[treasure_id]  GROUP BY  [dbo].[treasure].[city_city_id],  [dbo].[treasure].[difficulty],  [dbo].[treasure].[terrain],  [dbo].[treasure].[id]  

go

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

go


CREATE UNIQUE CLUSTERED INDEX [_dta_index__dta_mv_8_c_5_1845581613__K1_K2_K3_K4] ON [dbo].[_dta_mv_8]
(
	[_col_1] ASC,
	[_col_2] ASC,
	[_col_3] ASC,
	[_col_4] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_log_5_789577851__K7_K3D_1_2_4_5_6] ON [dbo].[treasure_log]
(
	[treasure_id] ASC,
	[log_time] DESC
)
INCLUDE ( 	[id],
	[description],
	[log_type],
	[session_start],
	[hunter_id]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_789577851_5] ON [dbo].[treasure_log]([session_start])
go

CREATE STATISTICS [_dta_stat_789577851_3_7] ON [dbo].[treasure_log]([log_time], [treasure_id])
go

CREATE STATISTICS [_dta_stat_789577851_7_6] ON [dbo].[treasure_log]([treasure_id], [hunter_id])
go

-- Tb:

-- 1
SET ANSI_PADDING ON

go

SET STATISTICS IO ON;

select id
FROM dbo.user_table;

select first_name
FROM dbo.user_table;

select first_name, last_name, mail, number, street 
FROM dbo.user_table;

CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K1_2_3] ON [dbo].[user_table]
(
	[id] ASC
)

INCLUDE ( 	[first_name],
	[last_name]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go


CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K1_2_3_option2] ON [dbo].[user_table]
(
	[id] ASC
)

INCLUDE ( 	[first_name],
	[last_name], [mail], [number],[street]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go


CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K1_2_3_option4] ON [dbo].[user_table]
(
	[id] ASC
)



select id, first_name, last_name
FROM dbo.user_table;

--2

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K3] ON [dbo].[user_table]
(
	[last_name] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_821577965_2] ON [dbo].[user_table]([first_name])
go

CREATE STATISTICS [_dta_stat_821577965_7] ON [dbo].[user_table]([city_city_id])
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_treasure_5_709577566__K5] ON [dbo].[treasure]
(
	[owner_id] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_709577566_2_3] ON [dbo].[treasure]([difficulty], [terrain])
go

CREATE STATISTICS [_dta_stat_709577566_1_4_2] ON [dbo].[treasure]([id], [city_city_id], [difficulty])
go

CREATE STATISTICS [_dta_stat_709577566_4_2_3] ON [dbo].[treasure]([city_city_id], [difficulty], [terrain])
go

CREATE STATISTICS [_dta_stat_709577566_1_2_3] ON [dbo].[treasure]([id], [difficulty], [terrain])
go

CREATE STATISTICS [_dta_stat_709577566_3_1_4_2] ON [dbo].[treasure]([terrain], [id], [city_city_id], [difficulty])
go

CREATE STATISTICS [_dta_stat_741577680_1_2] ON [dbo].[treasure_stages]([treasure_id], [stages_id])
go

