CREATE TABLE warehousing_return(
warehousing_return_id	INT IDENTITY(1,1)	NOT NULL
,project_id	INT	NOT NULL
,delivery_id	INT	NULL
,return_date	DATETIME	NOT NULL
,return_by	INT	NOT NULL
,notes	NTEXT(2147483646)	NULL
,created_date	DATETIME	NOT NULL
,created_by	INT	NOT NULL
,updated_date	DATETIME	NULL
,updated_by	INT	NULL)