CREATE TYPE bom_detail_tt AS TABLE(
bom_detail_id	INT	NULL
,bom_id	INT	NULL
,for_mrs	CHAR(1)	NULL
,product_id	INT	NULL
,quantity	DECIMAL(20)	NULL
,unit_of_measure_id	INT	NULL
,unit_cost_material	DECIMAL(20)	NULL
,unit_cost_labor	DECIMAL(20)	NULL
,total_cost_material	DECIMAL(20)	NULL
,total_cost_labor	DECIMAL(20)	NULL
,total_cost	DECIMAL(20)	NULL)