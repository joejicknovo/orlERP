
CREATE FUNCTION [dbo].[getProductGroupName](
	@product_group_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_product_group_name VARCHAR(100); 

   SELECT @l_product_group_name = product_group_name 
   FROM dbo.product_group 
   WHERE product_group_id = @product_group_id

   RETURN @l_product_group_name;
END;