CREATE TABLE warehousing(
warehousing_id	INT IDENTITY(1,1)	NOT NULL
,receiving_item_id	INT	NOT NULL
,item_id	INT	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,unit_price	DECIMAL(20)	NOT NULL
,quantity	DECIMAL(20)	NOT NULL
,warehouse_id	INT	NOT NULL
,rack_id	INT	NULL
,tag_no	VARCHAR(50)	NULL
,expiration_date	DATETIME	NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)