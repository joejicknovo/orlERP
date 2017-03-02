
CREATE FUNCTION [dbo].[getProductAttributeValue](
	@product_attribute_id INT
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_attribute_value VARCHAR(100); 

   SELECT @l_product_attribute_value = product_attribute_value 
   FROM dbo.product_attribute 
   WHERE product_attribute_id = @product_attribute_id

   RETURN @l_product_attribute_value;
END;