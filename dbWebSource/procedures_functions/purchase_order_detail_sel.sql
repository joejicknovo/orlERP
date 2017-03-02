
CREATE PROCEDURE [dbo].[purchase_order_detail_sel]
(
      @purchase_order_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @purchase_order_id IS NOT NULL  
		SELECT * FROM dbo.purchase_order_detail 
		WHERE purchase_order_id = @purchase_order_id;

END
 






