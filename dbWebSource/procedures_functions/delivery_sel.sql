

CREATE PROCEDURE [dbo].[delivery_sel]
(
    @delivery_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @delivery_id IS NOT NULL  
	 SELECT * FROM dbo.delivery WHERE delivery_id = @delivery_id; 
  ELSE
      SELECT * FROM dbo.delivery
	  ORDER BY delivery_id DESC; 
	
END
 







