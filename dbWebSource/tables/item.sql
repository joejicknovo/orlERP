CREATE TABLE item(
item_id	INT IDENTITY(1,1)	NOT NULL
,category_id	INT	NOT NULL
,item_code	VARCHAR(10)	NOT NULL
,item_name	VARCHAR(300)	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,image_url	VARCHAR(300)	NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)