CREATE PROCEDURE [dbo].[warehousing_detail_sel]
(
      @warehousing_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @warehousing_id IS NOT NULL  
		SELECT *,CONVERT(VARCHAR(10), product_id) + '|' + CONVERT(VARCHAR(10), unit_of_measure_id) + '|' + CONVERT(VARCHAR(20), unit_price) + '|' + CONVERT(VARCHAR(20),quantity) as product_id2 FROM dbo.warehousing_detail WHERE warehousing_id = @warehousing_id; 

END

