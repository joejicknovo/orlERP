CREATE TABLE supplier(
supplier_id	INT IDENTITY(1,1)	NOT NULL
,supplier_name	VARCHAR(300)	NOT NULL
,contact_name	VARCHAR(300)	NULL
,contact_no	VARCHAR(15)	NOT NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NULL
,created_date	DATETIME	NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)