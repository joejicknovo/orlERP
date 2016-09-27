CREATE TABLE delivery_item(
delivery_item_id	INT IDENTITY(1,1)	NOT NULL
,project_id	INT	NOT NULL
,delivery_date	DATETIME	NOT NULL
,delivery_incharge_id	INT	NULL
,company_vehicle_id	INT	NULL
,company_driver_id	INT	NULL
,outsource_shipper_id	INT	NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)