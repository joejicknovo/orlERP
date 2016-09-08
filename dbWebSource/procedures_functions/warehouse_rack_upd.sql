
CREATE PROCEDURE [dbo].[warehouse_rack_upd]
(
    @tt    warehouse_rack_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  warehouse_rack_code    = b.warehouse_rack_code
			,warehouse_rack_name	= b.warehouse_rack_name
			,is_active				= b.is_active
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.warehouse_rack a INNER JOIN @tt b
        ON a.warehouse_rack_id = b.warehouse_rack_id 
       WHERE (
				isnull(a.warehouse_rack_code,'') <> isnull(b.warehouse_rack_code,'')   
			OR	isnull(a.warehouse_rack_name,'') <> isnull(b.warehouse_rack_name,'')   
			OR	isnull(a.is_active,'')            <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO warehouse_rack (
         warehouse_rack_code 
		,warehouse_rack_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        warehouse_rack_code 
	   ,warehouse_rack_name	
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE warehouse_rack_id IS NULL;
END




