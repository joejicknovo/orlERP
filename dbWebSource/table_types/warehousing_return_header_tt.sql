CREATE TYPE warehousing_return_header_tt AS TABLE(
warehousing_return_id	INT	NULL
,project_id	INT	NULL
,delivery_id	INT	NULL
,return_date	DATETIME	NULL
,return_by	INT	NULL
,notes	NVARCHAR(0)	NULL)