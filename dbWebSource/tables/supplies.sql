CREATE TABLE supplies(
supply_id	INT IDENTITY(1,1)	NOT NULL
,seq_no	INT	NOT NULL
,supply_code	VARCHAR(25)	NOT NULL
,supply_desc	VARCHAR(100)	NOT NULL
,supply_type_id	INT	NOT NULL
,unit_id	INT	NOT NULL
,supply_srp	DECIMAL(9)	NOT NULL
,weight_serve	DECIMAL(9)	NOT NULL
,supply_cost	DECIMAL(9)	NOT NULL
,store_id	INT	NULL
,created_by	INT	NULL
,created_date	DATETIME	NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)