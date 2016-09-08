CREATE TABLE receiving_item_detail(
receiving_item_detail_id	INT IDENTITY(1,1)	NOT NULL
,receiving_item_id	INT	NOT NULL
,item_id	INT	NOT NULL
,quantity	DECIMAL(20)	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,unit_price	DECIMAL(20)	NOT NULL
,warehouse_id	INT	NOT NULL
,rack_id	INT	NULL
,tag_no	VARCHAR(10)	NULL
,expiration_date	DATETIME	NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)