

CREATE FUNCTION [dbo].[getProductName](
	@product_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_name VARCHAR(100); 
   SELECT @l_product_name = product_name FROM dbo.product WHERE product_id = @product_id
   RETURN @l_product_name;
END;