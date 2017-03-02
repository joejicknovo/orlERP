

CREATE FUNCTION [dbo].[getProductCode](
	@product_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_code VARCHAR(100); 
   SELECT @l_product_code = product_code FROM dbo.product WHERE product_id = @product_id
   RETURN @l_product_code;
END;