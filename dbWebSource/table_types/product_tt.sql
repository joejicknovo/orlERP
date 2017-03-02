CREATE TYPE product_tt AS TABLE(
product_id	INT	NULL
,product_name	NVARCHAR(600)	NULL
,unit_of_measure_id	INT	NULL
,product_brand_id	INT	NULL
,product_classification_id	INT	NULL
,product_category_id	INT	NULL
,product_group_id	INT	NULL
,product_type_id	INT	NULL
,product_attribute_id	INT	NULL
,is_active	CHAR(1)	NULL
,image_url	VARCHAR(300)	NULL)