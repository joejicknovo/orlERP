CREATE PROCEDURE dbo.TestTable1_upd 
(@tt TestTable1_tt READONLY, @user_id INT) 
 AS
SET NOCOUNT ON 
UPDATE a SET updated_by=dbo.getUserId(),updated_date = GETDATE()
,a.column2 = b.column2
,a.column3 = b.column3
,a.column4 = b.column4
,a.column5 = b.column5
,a.column6 = b.column6
 FROM TestTable1 a INNER JOIN @tt b  ON 
				      a. column_id = b.column_id AND ( 
 isnull(a.column2,0) = isnull(b.column2,0)
 OR  isnull(a.column3,'') = isnull(b.column3,'')
 OR  isnull(a.column4,'') = isnull(b.column4,'')
 OR  isnull(a.column5,'') = isnull(b.column5,'')
 OR  isnull(a.column6,'') = isnull(b.column6,''))

 INSERT INTO TestTable1(created_by,created_date 
,column2
,column3
,column4
,column5
,column6) SELECT dbo.getUserId(),GETDATE() 
,column2
,column3
,column4
,column5
,column6 FROM @tt WHERE 
column_id IS NULL 
