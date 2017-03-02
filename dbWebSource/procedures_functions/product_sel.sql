


CREATE PROCEDURE [dbo].[product_sel]
(
    @product_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @product_id IS NOT NULL  
	 SELECT * FROM dbo.product_v WHERE product_id = @product_id; 
  ELSE
     SELECT * FROM dbo.product_v
	 ORDER BY product_name; 
	
END
 







