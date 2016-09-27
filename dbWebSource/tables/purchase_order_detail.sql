CREATE TABLE purchase_order_detail(
purchase_order_detail_id	INT IDENTITY(1,1)	NOT NULL
,purchase_id	INT	NOT NULL
,item_id	INT	NOT NULL
,po_quantity	INT	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,po_unit_price	DECIMAL(20)	NOT NULL
,po_amount	DECIMAL(20)	NOT NULL)