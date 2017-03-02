

CREATE FUNCTION [dbo].[getProductCurrentDateWarehousing] 
(
	@product_id INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE @uprice DECIMAL(18,2);

	SELECT @uprice = unit_price 
	FROM dbo.warehousing_detail 
	WHERE product_id = @product_id
	AND created_date = (SELECT MAX(created_date) FROM dbo.warehousing_detail WHERE product_id = @product_id)
	GROUP BY unit_price

    RETURN @uprice;

END