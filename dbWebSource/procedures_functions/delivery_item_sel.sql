
create PROCEDURE [dbo].[delivery_item_sel]
(
    @delivery_item_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @delivery_item_id IS NOT NULL  
	 SELECT * FROM dbo.delivery_item WHERE delivery_item_id = @delivery_item_id; 
  ELSE
      SELECT * FROM delivery_item
	  ORDER BY delivery_item_id DESC; 
	
END
 




