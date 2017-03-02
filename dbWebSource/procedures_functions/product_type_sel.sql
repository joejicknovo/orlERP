
CREATE PROCEDURE [dbo].[product_type_sel]
(
    @product_group_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @product_group_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.product_type
	 WHERE product_group_id = @product_group_id
	 ORDER BY product_type_name; 
  ELSE
      SELECT * FROM dbo.product_type
	  ORDER BY product_type_name; 
	
END
 




