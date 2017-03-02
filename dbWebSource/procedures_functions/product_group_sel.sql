
CREATE PROCEDURE [dbo].[product_group_sel]
(
    @product_category_id  INT = null
  )
AS
BEGIN

  IF @product_category_id IS NOT NULL  
	 SELECT * FROM product_group WHERE product_category_id = @product_category_id; 
  ELSE
	 SELECT * FROM product_group; 
 	
END
 






