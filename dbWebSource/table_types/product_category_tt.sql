CREATE TYPE product_category_tt AS TABLE(
product_category_id	INT	NULL
,product_classification_id	INT	NULL
,product_category_code	VARCHAR(1)	NULL
,product_category_name	VARCHAR(300)	NULL
,is_active	CHAR(1)	NULL)