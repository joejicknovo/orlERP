
CREATE PROCEDURE [dbo].[project_sel]
(
   @project_id INT= NULL
)
AS
BEGIN
	DECLARE @stmt		VARCHAR(4000);

	SET @stmt = 'SELECT * FROM dbo.project';

	IF @project_id IS NOT NULL
		SET @stmt = @stmt + ' WHERE project_id='+ @project_id;
	
	
	EXEC (@stmt);
END
