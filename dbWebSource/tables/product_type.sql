CREATE TABLE product_type(
product_type_id	INT IDENTITY(1,1)	NOT NULL
,product_group_id	INT	NULL
,product_type_code	CHAR(1)	NOT NULL
,product_type_name	VARCHAR(300)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)