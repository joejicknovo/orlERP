CREATE TYPE warehouse_tt AS TABLE(
warehouse_id	INT	NULL
,warehouse_name	NVARCHAR(600)	NULL
,warehouse_location	NVARCHAR(600)	NULL
,warehouse_address	NVARCHAR(1000)	NULL
,warehouse_contact_no	NVARCHAR(30)	NULL
,warehouse_contact_person_id	INT	NULL
,is_active	CHAR(1)	NULL)