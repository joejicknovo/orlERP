

CREATE PROCEDURE [dbo].[category_item_sel]
(
    @category_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @category_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.category_item 
	 WHERE category_id = @category_id
	 ORDER BY category_name; 
  ELSE
      SELECT * FROM dbo.category_item
	  ORDER BY category_name; 
	
END
 
