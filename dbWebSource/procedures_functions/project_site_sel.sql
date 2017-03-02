


CREATE PROCEDURE [dbo].[project_site_sel]
(
    @project_site_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @project_site_id IS NOT NULL  
	 SELECT * FROM dbo.project_site WHERE project_site_id = @project_site_id; 
  ELSE
      SELECT * FROM project_site
	  ORDER BY project_site_name; 
	
END
 







