CREATE TYPE department_tt AS TABLE(
department_id	INT	NULL
,department_code	NVARCHAR(20)	NULL
,department_name	NVARCHAR(600)	NULL
,department_head_id	INT	NULL
,is_active	CHAR(1)	NULL)