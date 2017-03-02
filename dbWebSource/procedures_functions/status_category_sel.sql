

CREATE PROCEDURE [dbo].[status_category_sel]
(
    @status_category_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @status_category_id IS NOT NULL  
	 SELECT * FROM dbo.status_category WHERE status_category_id = @status_category_id; 
  ELSE
      SELECT * FROM status_category
	  ORDER BY status_category_code; 
	
END
 






