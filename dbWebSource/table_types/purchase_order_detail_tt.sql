CREATE TYPE purchase_order_detail_tt AS TABLE(
purchase_order_detail_id	INT	NULL
,purchase_id	INT	NULL
,item_id	INT	NULL
,po_quantity	INT	NULL
,unit_of_measure_id	INT	NULL
,po_unit_price	DECIMAL(20)	NULL
,po_amount	DECIMAL(20)	NULL)