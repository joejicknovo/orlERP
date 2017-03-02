

CREATE PROCEDURE [dbo].[status_sel]
(
    @status_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @status_id IS NOT NULL  
	 SELECT * FROM dbo.status_v WHERE @status_id = @status_id; 
  ELSE
     SELECT * FROM dbo.status_v
END
 






