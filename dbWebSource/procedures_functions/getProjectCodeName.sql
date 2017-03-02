
CREATE FUNCTION [dbo].[getProjectCodeName](
	@project_id int
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_project_code_name VARCHAR(100); 
   SELECT @l_project_code_name = (project_code + ' : ' + project_name) 
   FROM dbo.project WHERE project_id = @project_id
   ORDER BY project_name ASC;
   RETURN @l_project_code_name;
END;