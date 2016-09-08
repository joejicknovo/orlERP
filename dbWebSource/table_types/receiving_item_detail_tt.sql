CREATE TYPE receiving_item_detail_tt AS TABLE(
receiving_item_detail_id	INT	NULL
,receiving_item_id	INT	NULL
,item_id	INT	NULL
,quantity	DECIMAL(20)	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,warehouse_id	INT	NULL
,rack_id	INT	NULL
,tag_no	VARCHAR(10)	NULL
,expiration_date	DATETIME	NULL)