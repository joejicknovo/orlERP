

CREATE PROCEDURE [dbo].[bom_upd]
(
    @tt    bom_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  project_id			= b.project_id
			,bom_date			= b.bom_date
			,status_id	       = b.status_id
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.bom a INNER JOIN @tt b
        ON a.bom_id = b.bom_id 
       WHERE (
				isnull(a.project_id,0) <> isnull(b.project_id,0)   
			OR	isnull(a.bom_date,'') <> isnull(b.bom_date,'')   
			OR	isnull(a.status_id,0) <> isnull(b.status_id,0)   
	   )
	   
-- Insert Process

    INSERT INTO dbo.bom (
		 project_id
		,bom_date 
		,status_id
        ,created_by
        ,created_date
        )
    SELECT 
		project_id	
        ,bom_date 
	   ,status_id
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE bom_id IS NULL;
END
