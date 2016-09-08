CREATE TABLE unit_of_measure(
unit_of_measure_id	INT IDENTITY(1,1)	NOT NULL
,unit_of_measure_code	VARCHAR(10)	NOT NULL
,unit_of_measure_name	VARCHAR(200)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)