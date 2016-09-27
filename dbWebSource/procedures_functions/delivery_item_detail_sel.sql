
create PROCEDURE [dbo].[delivery_item_detail_sel]
(
      @delivery_item_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @delivery_item_id IS NOT NULL  
		SELECT * FROM dbo.delivery_item_detail WHERE delivery_item_id = @delivery_item_id; 

END
 




