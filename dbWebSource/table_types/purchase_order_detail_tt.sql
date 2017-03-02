CREATE TYPE purchase_order_detail_tt AS TABLE(
purchase_order_detail_id	INT	NULL
,purchase_order_id	INT	NULL
,product_id	INT	NULL
,unit_of_measure_id	INT	NULL
,unit_price	DECIMAL(20)	NULL
,quantity	DECIMAL(20)	NULL
,amount	DECIMAL(20)	NULL)