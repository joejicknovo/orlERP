
CREATE FUNCTION [dbo].[getClassificationName](
	@product_classification_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_classification_name VARCHAR(100); 

   SELECT @l_product_classification_name = product_classification_name 
   FROM dbo.product_classification 
   WHERE product_classification_id = @product_classification_id

   RETURN @l_product_classification_name;
END;