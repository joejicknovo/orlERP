CREATE TABLE menus_bak(
menu_id	INT	NOT NULL
,pmenu_id	INT	NULL
,menu_name	NVARCHAR(200)	NOT NULL
,seq_no	INT	NULL
,page_id	INT	NULL
,parameters	VARCHAR(50)	NULL
,is_default	VARCHAR(1)	NULL
,created_by	INT	NULL
,created_date	DATETIME	NULL
,updated_by	INT	NULL
,updated_date	DATETIME	NULL
,is_zsi_only	VARCHAR(1)	NULL)