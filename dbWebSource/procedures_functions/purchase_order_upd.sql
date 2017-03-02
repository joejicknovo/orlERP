
create PROCEDURE [dbo].[purchase_order_upd]
(
    @tt    purchase_order_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  mrs_id				= b.mrs_id
			,project_id			= b.project_id
			,po_datetime		= b.po_datetime
			,status_id	       = b.status_id
            ,updated_by        = @user_id
            ,updated_date      = GETDATE()
     FROM dbo.purchase_order a INNER JOIN @tt b
        ON a.purchase_order_id = b.purchase_order_id 
       WHERE (
				isnull(a.mrs_id,0) <> isnull(b.mrs_id,0)   
			OR	isnull(a.project_id,0) <> isnull(b.project_id,0)   
			OR	isnull(a.po_datetime,'') <> isnull(b.po_datetime,'')   
			OR	isnull(a.status_id,0) <> isnull(b.status_id,0)   
	   )
	   
-- Insert Process

    INSERT INTO purchase_order (
		 mrs_id
		,project_id
		,po_datetime 
		,status_id
        ,created_by
        ,created_date
        )
    SELECT 
		 mrs_id
		,project_id	
        ,po_datetime 
	   ,status_id
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE purchase_order_id IS NULL;
END






