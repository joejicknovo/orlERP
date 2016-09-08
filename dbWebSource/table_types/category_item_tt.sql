CREATE TYPE category_item_tt AS TABLE(
category_id	INT	NULL
,category_code	NVARCHAR(20)	NULL
,category_name	NVARCHAR(600)	NULL
,is_active	CHAR(1)	NULL)