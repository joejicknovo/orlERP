
CREATE PROCEDURE [dbo].[project_upd]
(
    @tt    project_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  project_name		= b.project_name
			,site_id			= b.site_id
			,start_date			= b.start_date
			,target_end_date	= b.target_end_date
			,manager_id			= b.manager_id
			,supervisor_id		= b.supervisor_id
			,status_id			= b.status_id
			,updated_by			= @user_id
            ,updated_date		= GETDATE()
     FROM dbo.project a INNER JOIN @tt b
        ON a.project_id = b.project_id 
       WHERE (
				isnull(a.project_name,'')		<> isnull(b.project_name,'')   
			OR	isnull(a.site_id,0)				<> isnull(b.site_id,0)   
			OR	isnull(a.start_date,'')			<> isnull(b.start_date,'')   
			OR	isnull(a.target_end_date,'')	<> isnull(b.target_end_date,'')   
			OR	isnull(a.manager_id, 0)			<> isnull(b.manager_id, 0)
			OR	isnull(a.supervisor_id,0)		<> isnull(b.supervisor_id,0)   
			OR	isnull(a.status_id,0)			<> isnull(b.status_id,0) 
	   )
	   
-- Insert Process

    INSERT INTO project (
         project_name	
		,site_id	
		,start_date	
		,target_end_date	
		,manager_id	
		,supervisor_id		
		,status_id	
		,created_by
        ,created_date
        )
    SELECT 
	    project_name	
	   ,site_id	
	   ,start_date	
	   ,target_end_date	
	   ,manager_id	
	   ,supervisor_id		
	   ,status_id
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE project_id IS NULL

	--Code generator
    DECLARE @terminator INT = 1;
	DECLARE @counter INT = (SELECT COUNT(project_id) FROM dbo.project WHERE project_code IS NULL);

	WHILE @terminator <= @counter
		BEGIN
			UPDATE dbo.project
			SET project_code = (SELECT 'PJ' + REPLICATE('0',4-LEN(RTRIM(project_id))) + RTRIM(project_id))
			WHERE project_id = (SELECT TOP 1 project_id FROM dbo.project WHERE project_code IS NULL);

			SET @terminator = @terminator + 1;
		END
END







