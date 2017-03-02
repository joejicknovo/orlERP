

CREATE PROCEDURE [dbo].[product_type_sel_option]
(
    @product_group_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  --IF @product_group_id IS NOT NULL  
	 SELECT product_type_id AS value, 
	        '(' + product_type_code + ') ' + product_type_name AS text
	 FROM dbo.product_type
	 WHERE product_group_id = @product_group_id
	 ORDER BY product_type_code, product_type_name; 
	
END




