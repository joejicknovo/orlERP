CREATE TYPE customer_tt AS TABLE(
customer_id	INT	NULL
,customer_code	NVARCHAR(20)	NULL
,customer_name	NVARCHAR(400)	NULL
,contact_person	NVARCHAR(600)	NULL
,address	NVARCHAR(6000)	NULL
,mobile_no	NVARCHAR(30)	NULL
,fox_no	NVARCHAR(30)	NULL
,office_no	NVARCHAR(30)	NULL
,email_address	NVARCHAR(600)	NULL
,is_active	CHAR(1)	NULL)