CREATE PROCEDURE [dbo].[warehouse_sel]
(
    @warehouse_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @warehouse_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.warehouse
	 WHERE warehouse_id = @warehouse_id
	 ORDER BY warehouse_name; 
  ELSE
      SELECT * FROM dbo.warehouse
	  ORDER BY warehouse_name; 
	
END
 


