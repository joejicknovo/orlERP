CREATE TABLE product_category(
product_category_id	INT IDENTITY(1,1)	NOT NULL
,product_classification_id	INT	NOT NULL
,product_category_code	VARCHAR(10)	NOT NULL
,product_category_name	VARCHAR(300)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)