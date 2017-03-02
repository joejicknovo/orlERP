

CREATE PROCEDURE [dbo].[status_upd]
(
    @tt    status_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  status_category_id     = b.status_category_id
			,status_code	   = b.status_code
			,status_name	   = b.status_name
			,is_active	       = b.is_active
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.status a INNER JOIN @tt b
        ON a.status_id = b.status_id
       WHERE (
				isnull(a.status_category_id,0) <> isnull(b.status_category_id,0)   
			OR	isnull(a.status_code,'') <> isnull(b.status_code,'')   
			OR	isnull(a.status_name,'') <> isnull(b.status_name,'')   
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO status (
         status_category_id 
		,status_code
		,status_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        status_category_id 
	   ,status_code	
	   ,status_name
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE status_id IS NULL;
END






