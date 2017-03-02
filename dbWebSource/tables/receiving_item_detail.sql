CREATE TABLE receiving_item_detail(
receiving_item_detail_id	INT IDENTITY(1,1)	NOT NULL
,receiving_item_id	INT	NOT NULL
,product_id	INT	NOT NULL
,quantity	DECIMAL(20)	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,unit_price	DECIMAL(20)	NOT NULL
,amount	DECIMAL(20)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)