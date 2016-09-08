CREATE TABLE category_item(
category_id	INT IDENTITY(1,1)	NOT NULL
,category_code	VARCHAR(10)	NOT NULL
,category_name	VARCHAR(300)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)