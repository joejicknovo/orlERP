


CREATE PROCEDURE [dbo].[project_site_upd]
(
    @tt    project_site_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  project_site_name      = b.project_site_name
			,project_site_address	= b.project_site_address
			,is_active				= b.is_active
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.project_site a INNER JOIN @tt b
        ON a.project_site_id = b.project_site_id 
       WHERE (
				isnull(a.project_site_name,'') <> isnull(b.project_site_name,'')   
			OR	isnull(a.project_site_address,'') <> isnull(b.project_site_address,'') 
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')  
	   )

-- Insert Process

    INSERT INTO project_site (
         project_site_name 
		,project_site_address
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        project_site_name 
	   ,project_site_address	
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE project_site_id IS NULL;
END







