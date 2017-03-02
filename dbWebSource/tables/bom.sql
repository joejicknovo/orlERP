CREATE TABLE bom(
bom_id	INT IDENTITY(1,1)	NOT NULL
,project_id	INT	NOT NULL
,bom_date	DATETIME	NOT NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)