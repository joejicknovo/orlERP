
CREATE PROCEDURE [dbo].[receiving_item_detail_sel]
(
      @receiving_item_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @receiving_item_id IS NOT NULL  
		SELECT * FROM dbo.receiving_item_detail WHERE receiving_item_id = @receiving_item_id; 

END
 






