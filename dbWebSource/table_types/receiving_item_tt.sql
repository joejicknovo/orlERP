CREATE TYPE receiving_item_tt AS TABLE(
receiving_item_id	INT	NULL
,purchase_order_id	INT	NULL
,delivered_by	VARCHAR(300)	NULL
,remark	VARCHAR(2000)	NULL
,status_id	INT	NULL)