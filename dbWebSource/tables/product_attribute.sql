CREATE TABLE product_attribute(
product_attribute_id	INT IDENTITY(1,1)	NOT NULL
,product_type_id	INT	NOT NULL
,product_attribute_sequence_no	INT	NOT NULL
,product_attribute_value	NVARCHAR(1000)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)