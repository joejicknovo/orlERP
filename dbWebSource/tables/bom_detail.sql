CREATE TABLE bom_detail(
bom_detail_id	INT IDENTITY(1,1)	NOT NULL
,bom_id	INT	NOT NULL
,for_mrs	CHAR(1)	NOT NULL
,product_id	INT	NOT NULL
,quantity	DECIMAL(20)	NOT NULL
,unit_of_measure_id	INT	NOT NULL
,unit_cost_material	DECIMAL(20)	NOT NULL
,unit_cost_labor	DECIMAL(20)	NOT NULL
,total_cost_material	DECIMAL(20)	NOT NULL
,total_cost_labor	DECIMAL(20)	NOT NULL
,total_cost	DECIMAL(20)	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)