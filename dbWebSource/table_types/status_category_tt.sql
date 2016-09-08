CREATE TYPE status_category_tt AS TABLE(
status_category_id	INT	NULL
,status_category_code	NVARCHAR(20)	NULL
,status_category_description	NVARCHAR(600)	NULL
,is_active	CHAR(1)	NULL)