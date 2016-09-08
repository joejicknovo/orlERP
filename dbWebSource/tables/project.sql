CREATE TABLE project(
project_id	INT IDENTITY(1,1)	NOT NULL
,project_code	VARCHAR(10)	NOT NULL
,project_name	VARCHAR(300)	NOT NULL
,site_id	INT	NOT NULL
,start_date	DATETIME	NOT NULL
,target_end_date	DATETIME	NOT NULL
,manager_id	INT	NOT NULL
,supervisor_id	INT	NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)