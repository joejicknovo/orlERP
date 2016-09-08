

CREATE PROCEDURE [dbo].[category_item_upd]
(
    @tt    category_item_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  category_code     = b.category_code
			,category_name	   = b.category_name
			,is_active	       = b.is_active
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.category_item a INNER JOIN @tt b
        ON a.category_id = b.category_id 
       WHERE (
				isnull(a.category_code,'') <> isnull(b.category_code,'')   
			OR	isnull(a.category_name,'') <> isnull(b.category_name,'')   
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO category_item (
         category_code 
		,category_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        category_code 
	   ,category_name	
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE category_id IS NULL;
END




