CREATE TABLE product(
product_id	INT IDENTITY(1,1)	NOT NULL
,product_code	VARCHAR(15)	NULL
,product_name	VARCHAR(300)	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,product_classification_id	INT	NOT NULL
,product_category_id	INT	NOT NULL
,product_group_id	INT	NOT NULL
,product_type_id	INT	NOT NULL
,product_brand_id	INT	NULL
,product_attribute_id	INT	NOT NULL
,image_url	VARCHAR(300)	NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)