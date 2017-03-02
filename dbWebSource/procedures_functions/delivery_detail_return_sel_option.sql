
CREATE PROCEDURE [dbo].[delivery_detail_return_sel_option]
(
      @delivery_id  INT = NULL
)
AS
BEGIN

SET NOCOUNT ON

	IF @delivery_id IS NOT NULL  
		SELECT product_id,
		       dbo.getProductCodeName(product_id) as product,
		       unit_of_measure_id,unit_price,quantity 
		FROM dbo.delivery_detail 
		WHERE delivery_id = @delivery_id
		ORDER BY product;

END
 








