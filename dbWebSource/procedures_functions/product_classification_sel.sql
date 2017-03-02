

CREATE PROCEDURE [dbo].[product_classification_sel]
(
    @product_classification_id  INT = null
)
AS
BEGIN

	SET NOCOUNT ON

	IF @product_classification_id IS NOT NULL  
		SELECT * 
		FROM dbo.product_classification 
		WHERE product_classification_id = @product_classification_id
		ORDER BY product_classification_name; 
	ELSE
		SELECT * FROM dbo.product_classification
		ORDER BY product_classification_id DESC; 
	
END




