CREATE TYPE employee_tt AS TABLE(
employee_id	INT	NULL
,employee_first_name	NVARCHAR(100)	NULL
,employee_middle_name	NVARCHAR(100)	NULL
,employee_last_name	NVARCHAR(100)	NULL
,employee_gender	CHAR(1)	NULL
,employee_birth_date	DATETIME	NULL
,date_hired	DATETIME	NULL
,termination_date	DATETIME	NULL
,position_id	INT	NULL
,user_id	INT	NULL
,note	VARCHAR(0)	NULL
,status_id	INT	NULL)