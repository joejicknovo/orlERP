CREATE PROCEDURE [dbo].[warehousing_sel]
(
    @warehousing_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @warehousing_id IS NOT NULL  
	 SELECT * FROM dbo.warehousing WHERE warehousing_id = @warehousing_id; 
  ELSE
      SELECT * FROM warehousing
	  ORDER BY warehousing_id DESC; 
	
END

