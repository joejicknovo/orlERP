
CREATE PROCEDURE [dbo].[mrs_upd]
(
    @tt    mrs_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  bom_id				= b.bom_id
			,project_id			= b.project_id
			,mrs_date			= b.mrs_date
			,status_id	       = b.status_id
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.mrs a INNER JOIN @tt b
        ON a.mrs_id = b.mrs_id 
       WHERE (
				isnull(a.bom_id,0) <> isnull(b.bom_id,0)   
			OR	isnull(a.project_id,0) <> isnull(b.project_id,0)   
			OR	isnull(a.mrs_date,'') <> isnull(b.mrs_date,'')   
			OR	isnull(a.status_id,0) <> isnull(b.status_id,0)   
	   )
	   
-- Insert Process

    INSERT INTO mrs (
		 bom_id
		,project_id
		,mrs_date 
		,status_id
        ,created_by
        ,created_date
        )
    SELECT 
		 bom_id
		,project_id	
        ,mrs_date 
	    ,status_id
        ,@user_id
        ,GETDATE()
    FROM @tt
    WHERE mrs_id IS NULL;
END



