
CREATE PROCEDURE [dbo].[warehouse_rack_sel]
(
    @warehouse_rack_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @warehouse_rack_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.warehouse_rack 
	 WHERE warehouse_rack_id = @warehouse_rack_id
	 ORDER BY warehouse_rack_name; 
  ELSE
      SELECT * FROM dbo.warehouse_rack
	  ORDER BY warehouse_rack_name; 
	
END

