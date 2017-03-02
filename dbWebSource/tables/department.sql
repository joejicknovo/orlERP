CREATE TABLE department(
department_id	INT IDENTITY(1,1)	NOT NULL
,department_code	VARCHAR(10)	NOT NULL
,department_name	VARCHAR(300)	NOT NULL
,department_head_id	INT	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)