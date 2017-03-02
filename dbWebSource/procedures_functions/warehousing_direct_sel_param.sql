
CREATE PROCEDURE [dbo].[warehousing_direct_sel_param]
(
	  @warehousing_detail_id INT
)
AS
BEGIN

SET NOCOUNT ON

	IF @warehousing_detail_id IS NOT NULL
		BEGIN
			SELECT product_id, unit_of_measure_id, unit_price, quantity, warehouse_id, rack_id, tag_no, expiration_date
			FROM dbo.warehousing_detail
			WHERE warehousing_detail_id = @warehousing_detail_id;
		END
END


