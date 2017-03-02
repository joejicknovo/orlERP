CREATE PROCEDURE [dbo].[warehousing_detail_product_sel]
(
      @receiving_item_id  INT = NULL
)
AS
BEGIN

SET NOCOUNT ON

	IF @receiving_item_id IS NOT NULL  
	    SELECT
			   p.product_id
			  ,p.product_name
			  ,r.unit_of_measure_id
			  ,r.unit_price
			  ,r.quantity
		FROM dbo.product as p
		INNER JOIN dbo.receiving_item_detail as r ON p.product_id = r.product_id
		WHERE r.receiving_item_id = @receiving_item_id;
	ELSE
		SELECT NULL;
END




