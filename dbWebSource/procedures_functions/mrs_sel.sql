


CREATE PROCEDURE [dbo].[mrs_sel]
(
    @mrs_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @mrs_id IS NOT NULL  
	 SELECT * FROM dbo.mrs WHERE MRS_id = @mrs_id; 
  ELSE
      SELECT * FROM dbo.mrs
	  ORDER BY mrs_id DESC; 
	
END



