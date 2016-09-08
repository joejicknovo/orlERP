CREATE TABLE customer(
customer_id	INT IDENTITY(1,1)	NOT NULL
,customer_code	VARCHAR(10)	NOT NULL
,customer_name	VARCHAR(300)	NOT NULL
,contact_person	VARCHAR(300)	NOT NULL
,address	VARCHAR(3000)	NOT NULL
,mobile_no	VARCHAR(15)	NOT NULL
,fox_no	VARCHAR(15)	NULL
,office_no	VARCHAR(15)	NULL
,email_address	VARCHAR(300)	NULL
,is_active	CHAR(1)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)