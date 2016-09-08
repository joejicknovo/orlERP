CREATE TYPE item_tt AS TABLE(
item_id	INT	NULL
,category_id	INT	NULL
,item_code	NVARCHAR(20)	NULL
,item_name	NVARCHAR(600)	NULL
,unit_of_measure_id	INT	NULL
,image_url	VARCHAR(300)	NULL
,is_active	CHAR(1)	NULL)