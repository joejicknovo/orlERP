CREATE TYPE product_attribute_tt AS TABLE(
product_attribute_id	INT	NULL
,product_type_id	INT	NULL
,product_attribute_sequence_no	INT	NULL
,product_attribute_value	NVARCHAR(1000)	NULL
,is_active	CHAR(1)	NULL)