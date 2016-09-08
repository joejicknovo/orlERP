CREATE TYPE status_tt AS TABLE(
status_id	INT	NULL
,status_category_id	INT	NULL
,status_code	NVARCHAR(20)	NULL
,status_name	NVARCHAR(600)	NULL
,is_active	CHAR(1)	NULL)