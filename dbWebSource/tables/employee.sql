CREATE TABLE employee(
employee_id	INT IDENTITY(1,1)	NOT NULL
,employee_first_name	VARCHAR(50)	NOT NULL
,employee_middle_name	VARCHAR(50)	NOT NULL
,employee_last_name	VARCHAR(50)	NOT NULL
,employee_gender	CHAR(1)	NOT NULL
,employee_birth_date	DATETIME	NOT NULL
,date_hired	DATETIME	NULL
,termination_date	DATETIME	NULL
,position_id	INT	NOT NULL
,user_id	INT	NULL
,note	TEXT(2147483647)	NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)