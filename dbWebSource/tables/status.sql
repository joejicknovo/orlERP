CREATE TABLE status(
status_id	INT IDENTITY(1,1)	NOT NULL
,status_category_id	INT	NOT NULL
,status_code	VARCHAR(10)	NOT NULL
,status_name	VARCHAR(300)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)