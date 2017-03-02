CREATE TABLE warehouse(
warehouse_id	INT IDENTITY(1,1)	NOT NULL
,warehouse_code	VARCHAR(10)	NULL
,warehouse_name	VARCHAR(300)	NOT NULL
,warehouse_location	VARCHAR(300)	NOT NULL
,warehouse_address	VARCHAR(500)	NOT NULL
,warehouse_contact_no	VARCHAR(15)	NULL
,warehouse_contact_person_id	INT	NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)