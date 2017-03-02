
CREATE PROCEDURE [dbo].[supplier_upd]
(
    @tt    supplier_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  supplier_name  = b.supplier_name
			,contact_name   = b.contact_name
			,contact_no	    = b.contact_no
			,is_active	    = b.is_active
            ,updated_by     = @user_id
            ,updated_date   = GETDATE()
     FROM dbo.supplier a INNER JOIN @tt b
        ON a.supplier_id = b.supplier_id 
       WHERE (
				isnull(a.supplier_name,'') <> isnull(b.supplier_name,'')   
			OR	isnull(a.contact_name,'') <> isnull(b.contact_name,'')   
			OR	isnull(a.contact_no,'') <> isnull(b.contact_no,'')   
			OR	isnull(a.is_active,'') <> isnull(b.is_active,'')   
	   )

-- Insert Process

    INSERT INTO supplier (
         supplier_name
		,contact_name 
		,contact_no	  
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        supplier_name
	   ,contact_name 
	   ,contact_no	  
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE supplier_id IS NULL

END



