CREATE TABLE receiving_item(
receiving_item_id	INT IDENTITY(1,1)	NOT NULL
,purchase_order_id	INT	NULL
,delivered_by	VARCHAR(300)	NOT NULL
,remark	VARCHAR(2000)	NULL
,status_id	INT	NULL
,received_by	INT	NOT NULL
,received_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)