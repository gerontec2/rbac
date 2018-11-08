CREATE TABLE [dbo].[ad_user_group](
	[username] [varchar](88) NULL,
	[userdom] [varchar](22) NULL,
	[uac] [int] NULL,
	[email] [varchar](166) NULL,
	[groupdom] [varchar](22) NULL,
	[adgroup] [varchar](166) NULL,
	[department] [varchar](66) NULL,
	[org] [varchar](66) NULL,
	[company] [varchar](66) NULL
);

CREATE TABLE [dbo].[ad_user_group1](
	[username] [varchar](88) NULL,
	[userdom] [varchar](22) NULL,
	[uac] [int] NULL,
	[email] [varchar](166) NULL,
	[groupdom] [varchar](22) NULL,
	[adgroup] [varchar](166) NULL,
	[department] [varchar](66) NULL,
	[org] [varchar](66) NULL,
	[company] [varchar](66) NULL
);

CREATE TABLE [dbo].[ad_group_grant](
	[ts] [datetime] NOT NULL,
	[username] [varchar](88) NULL,
	[adgroup] [varchar](66) NULL
);

CREATE TABLE [dbo].[ad_group_revoke](
	[ts] [datetime] NOT NULL,
	[username] [varchar](88) NULL,
	[adgroup] [varchar](66) NULL
);

