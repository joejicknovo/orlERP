CREATE TYPE delivery_detail_tt AS TABLE(
delivery_detail_id	INT	NULL
,delivery_id	INT	NULL
,product_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,amount	DECIMAL(20)	NULL)