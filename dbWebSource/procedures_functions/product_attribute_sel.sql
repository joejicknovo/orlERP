
CREATE PROCEDURE [dbo].[product_attribute_sel]
(
    @product_type_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @product_type_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.product_attribute
	 WHERE product_type_id = @product_type_id
	 ORDER BY product_attribute_value; 
  ELSE
      SELECT * FROM dbo.product_attribute
	  ORDER BY product_attribute_value; 
	
END



