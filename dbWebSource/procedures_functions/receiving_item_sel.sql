
CREATE PROCEDURE [dbo].[receiving_item_sel]
(
    @receiving_item_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @receiving_item_id IS NOT NULL  
	 SELECT * FROM dbo.receiving_item WHERE receiving_item_id = @receiving_item_id; 
  ELSE
      SELECT * FROM receiving_item
	  ORDER BY receiving_item_id DESC; 
	
END
 




