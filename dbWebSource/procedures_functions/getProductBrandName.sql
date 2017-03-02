
CREATE FUNCTION [dbo].[getProductBrandName](
	@product_brand_id INT
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_brand_name VARCHAR(100); 

   SELECT @l_product_brand_name = product_brand_name 
   FROM dbo.product_brand 
   WHERE product_brand_id = @product_brand_id

   RETURN @l_product_brand_name;
END;