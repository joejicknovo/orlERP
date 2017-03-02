
CREATE PROCEDURE [dbo].[warehousing_return_sel_by_warehousing_detail_id]
(
	  @warehousing_detail_id INT
)
AS
BEGIN

	SET NOCOUNT ON

	SELECT *
	FROM warehousing_return
	WHERE warehousing_return_id = (
		SELECT warehousing_return_id 
		FROM warehousing_detail 
		WHERE warehousing_detail_id = @warehousing_detail_id
	)
END



