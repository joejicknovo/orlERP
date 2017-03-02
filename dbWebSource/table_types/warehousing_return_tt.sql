CREATE TYPE warehousing_return_tt AS TABLE(
warehousing_detail_id	INT	NULL
,warehousing_id	INT	NULL
,product_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,warehouse_id	INT	NULL
,rack_id	INT	NULL
,tag_no	VARCHAR(50)	NULL
,expiration_date	DATETIME	NULL
,warehousing_return_id	INT	NULL)