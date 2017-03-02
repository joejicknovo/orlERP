
CREATE PROCEDURE [dbo].[product_group_sel_option]
(
    @product_category_id  INT = null
  )
AS
BEGIN

  IF @product_category_id IS NOT NULL  
	 SELECT product_group_id AS value, 
	        '(' + product_group_code + ') ' + product_group_name AS text
	 FROM product_group 
	 WHERE product_category_id = @product_category_id
	 ORDER BY product_group_name;
  ELSE
    SELECT product_group_id AS value, 
	       '(' + product_group_code + ') ' + product_group_name AS text
	 FROM product_group 
	 ORDER BY product_group_name;
 	
END
 






