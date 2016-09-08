CREATE TYPE warehousing_tt AS TABLE(
warehousing_id	INT	NULL
,receiving_item_id	INT	NULL
,item_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,warehouse_id	INT	NULL
,rack_id	INT	NULL
,tag_no	VARCHAR(50)	NULL
,expiration_date	DATETIME	NULL
,status_id	INT	NULL)