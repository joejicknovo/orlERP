CREATE TYPE receiving_item_detail_tt AS TABLE(
receiving_item_detail_id	INT	NULL
,receiving_item_id	INT	NULL
,product_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,amount	DECIMAL(20)	NULL)