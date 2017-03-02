

CREATE PROCEDURE [dbo].[product_classification_sel_option]

AS
BEGIN

	SET NOCOUNT ON

	SELECT product_classification_id AS value, '(' + product_classification_code + ') ' + product_classification_name AS text
	FROM dbo.product_classification 
	ORDER BY product_classification_name; 
	
END




