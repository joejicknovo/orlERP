CREATE TYPE delivery_item_detail_tt AS TABLE(
delivery_item_detail_id	INT	NULL
,delivery_item_id	INT	NULL
,item_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,amount	DECIMAL(20)	NULL)