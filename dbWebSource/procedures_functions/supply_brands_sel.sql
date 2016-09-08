CREATE PROCEDURE [dbo].[supply_brands_sel]
(
    @supply_brand_id  INT = null

)
AS
BEGIN
  DECLARE @stmt		VARCHAR(4000);
 
  IF @supply_brand_id <> '' 
		SET @stmt = @stmt + ' AND supply_brand_id='+ CAST(@supply_brand_id AS VARCHAR(50));
   exec (@stmt);
END
 




