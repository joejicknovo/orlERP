
create PROCEDURE [dbo].[project_sel]
(
   @project_id INT
)
AS
BEGIN
	DECLARE @stmt		VARCHAR(4000);

	SET @stmt = 'SELECT * FROM dbo.project';

	IF @project_id <> 0 
		SET @stmt = @stmt + ' WHERE project_id='+ @project_id;
	
	
	EXEC (@stmt);
END
