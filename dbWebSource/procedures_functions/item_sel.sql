

CREATE PROCEDURE [dbo].[item_sel]
(
    @category_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @category_id IS NOT NULL  
	 SELECT * FROM dbo.item WHERE category_id = @category_id; 
  ELSE
      SELECT * FROM item
	  ORDER BY item_name; 
	
END
 




