CREATE TABLE project_site(
project_site_id	INT IDENTITY(1,1)	NOT NULL
,project_site_name	VARCHAR(300)	NOT NULL
,project_site_address	VARCHAR(300)	NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)