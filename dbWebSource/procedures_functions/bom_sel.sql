


CREATE PROCEDURE [dbo].[bom_sel]
(
    @bom_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @bom_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.bom 
	 WHERE bom_id = @bom_id
	 ORDER BY bom_id; 
  ELSE
      SELECT * FROM dbo.bom
	  ORDER BY bom_id DESC; 
	
END
