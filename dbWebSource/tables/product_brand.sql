CREATE TABLE product_brand(
product_brand_id	INT IDENTITY(1,1)	NOT NULL
,product_brand_code	NVARCHAR(20)	NOT NULL
,product_brand_name	NVARCHAR(600)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)