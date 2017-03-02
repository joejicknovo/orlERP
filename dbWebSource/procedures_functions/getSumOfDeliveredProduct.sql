

CREATE FUNCTION [dbo].[getSumOfDeliveredProduct] 
(
	@product_id INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @quantity DECIMAL(18,2);

	SELECT @quantity = IIF(SUM(quantity)=NULL, 0, SUM(quantity)) 
	FROM dbo.delivery_detail 
	WHERE product_id = @product_id

    RETURN @quantity;

END