use [catchem]
go

SET ANSI_PADDING ON

go

CREATE CLUSTERED INDEX [_dta_index_treasure_stages_c_5_741577680__K1] ON [dbo].[treasure_stages]
(
	[treasure_id] ASC
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

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K1_2_3] ON [dbo].[user_table]
(
	[id] ASC
)
INCLUDE ( 	[first_name],
	[last_name]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

SET ANSI_PADDING ON

go

CREATE NONCLUSTERED INDEX [_dta_index_user_table_5_821577965__K3] ON [dbo].[user_table]
(
	[last_name] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
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

