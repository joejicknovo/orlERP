
CREATE PROCEDURE [dbo].[product_brand_sel]
(
     @product_brand_id  INT = NULL
	,@user_id  INT = NULL
)
AS
BEGIN
	DECLARE @stmt		VARCHAR(4000);
 
	SET @stmt = 'SELECT * FROM dbo.product_brand';
	IF @product_brand_id <> '' 
		SET @stmt = @stmt + ' WHERE product_brand_id='+ CAST(@product_brand_id AS VARCHAR(50));
	EXEC (@stmt);
END

