

CREATE PROCEDURE [dbo].[product_attribute_sel_option]
(
    @product_type_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @product_type_id IS NOT NULL  
	 SELECT product_attribute_id AS value, 
	        '(' + CAST(product_attribute_sequence_no AS VARCHAR(1000)) + ') ' + product_attribute_value AS text
	 FROM dbo.product_attribute
	 WHERE product_type_id = @product_type_id
	 ORDER BY product_attribute_value; 
  ELSE
    SELECT product_attribute_id AS value, 
	       '(' + CAST(product_attribute_sequence_no AS VARCHAR(1000)) + ') ' + product_attribute_value AS text
	 FROM dbo.product_attribute
	 ORDER BY product_attribute_value; 
	
END




