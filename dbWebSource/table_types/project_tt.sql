CREATE TYPE project_tt AS TABLE(
project_id	INT	NULL
,project_name	NVARCHAR(600)	NULL
,site_id	INT	NULL
,start_date	DATETIME	NULL
,target_end_date	DATETIME	NULL
,manager_id	INT	NULL
,supervisor_id	INT	NULL
,status_id	INT	NULL)