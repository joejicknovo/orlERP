

create PROCEDURE [dbo].[item_upd]
(
    @tt    item_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  category_id        = b.category_id
			,item_code          = b.item_code
			,item_name	        = b.item_name
			,unit_of_measure_id = b.unit_of_measure_id
			,image_url		    = b.image_url
			,is_active	        = b.is_active
            ,updated_by         = @user_id
            ,updated_date       = GETDATE()
     FROM dbo.item a INNER JOIN @tt b
        ON a.item_id = b.item_id 
       WHERE (
				isnull(a.category_id,0) <> isnull(b.category_id,0)   
			OR	isnull(a.item_code,'') <> isnull(b.item_code,'')   
			OR	isnull(a.item_name,'') <> isnull(b.item_name,'')   
			OR	isnull(a.unit_of_measure_id,0) <> isnull(b.unit_of_measure_id,0)   
			OR	isnull(a.image_url,0) <> isnull(b.image_url,0)  
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')   
	   )

-- Insert Process

    INSERT INTO Item (
         category_id
		,item_code 
		,item_name
		,unit_of_measure_id	
		,image_url  
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        category_id
	   ,item_code 
	   ,item_name	
	   ,unit_of_measure_id  
	   ,image_url  
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE item_id IS NULL;
END




