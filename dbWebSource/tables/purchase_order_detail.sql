CREATE TABLE purchase_order_detail(
purchase_order_detail_id	INT IDENTITY(1,1)	NOT NULL
,purchase_order_id	INT	NOT NULL
,product_id	INT	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,unit_price	DECIMAL(20)	NOT NULL
,quantity	DECIMAL(20)	NOT NULL
,amount	DECIMAL(20)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)