
CREATE FUNCTION [dbo].[getProductTypeName](
	@product_type_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_type_name VARCHAR(100); 

   SELECT @l_product_type_name = product_type_name 
   FROM dbo.product_type 
   WHERE product_type_id = @product_type_id

   RETURN @l_product_type_name;
END;
