
CREATE PROCEDURE [dbo].[product_category_sel_option]
(
    @product_classification_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  --IF @product_classification_id IS NOT NULL  
	 SELECT product_category_id AS value, 
	        '(' + product_category_code + ') ' + product_category_name AS text
	 FROM dbo.product_category
	 WHERE product_classification_id = @product_classification_id
	 ORDER BY product_category_name; 
  --ELSE
  --  SELECT product_category_id AS value, 
	 --      '(' + product_category_code + ') ' + product_category_name AS text
	 --FROM dbo.product_category
	 --ORDER BY product_category_name;

END



