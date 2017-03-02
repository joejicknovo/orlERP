CREATE TABLE purchase_order(
purchase_order_id	INT IDENTITY(1,1)	NOT NULL
,mrs_id	INT	NOT NULL
,project_id	INT	NOT NULL
,po_datetime	DATETIME	NOT NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)