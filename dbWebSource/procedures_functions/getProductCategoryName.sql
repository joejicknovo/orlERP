
CREATE FUNCTION [dbo].[getProductCategoryName](
	@product_category_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_category_name VARCHAR(100); 

   SELECT @l_product_category_name = product_category_name 
   FROM dbo.product_category 
   WHERE product_category_id = @product_category_id

   RETURN @l_product_category_name;
END;
