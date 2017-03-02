CREATE TABLE warehousing(
warehousing_id	INT IDENTITY(1,1)	NOT NULL
,receiving_item_id	INT	NOT NULL
,status_id	INT	NOT NULL
,created_by	INT	NOT NULL
,created_date	DATETIME	NOT NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL)