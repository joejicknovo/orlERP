

CREATE PROCEDURE [dbo].[status_category_upd]
(
    @tt    status_category_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  status_category_code     = b.status_category_code
			,status_category_description	   = b.status_category_description
			,is_active	       = b.is_active
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.status_category a INNER JOIN @tt b
        ON a.status_category_id = b.status_category_id
       WHERE (
				isnull(a.status_category_code,'') <> isnull(b.status_category_code,'')   
			OR	isnull(a.status_category_description,'') <> isnull(b.status_category_description,'')   
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO status_category (
         status_category_code 
		,status_category_description
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        status_category_code 
	   ,status_category_description	
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE status_category_id IS NULL;
END




