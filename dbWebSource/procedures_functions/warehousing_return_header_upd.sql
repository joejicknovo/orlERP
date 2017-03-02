
CREATE PROCEDURE [dbo].[warehousing_return_header_upd]
(
    @tt    warehousing_return_header_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  project_id				= b.project_id
		    ,delivery_id			= b.delivery_id
			,return_date			= b.return_date
			,return_by				= b.return_by
			,notes					= b.notes
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.warehousing_return a INNER JOIN @tt b
        ON a.warehousing_return_id = b.warehousing_return_id 
       WHERE (
				isnull(a.project_id,0)				<> isnull(b.project_id,0) 
			OR  isnull(a.delivery_id,0)				<> isnull(b.delivery_id,0)   
			OR	isnull(a.return_date,0)				<> isnull(b.return_date,0)
			OR	isnull(a.return_by,0)				<> isnull(b.return_by,0)
			OR	isnull(a.notes,0)					<> isnull(b.notes,0) 
	   )

-- Insert Process

    INSERT INTO warehousing_return (
         project_id 
		,delivery_id
		,return_date	
		,return_by
		,notes
		,created_by
        ,created_date
        )
    SELECT 
         project_id
		,delivery_id
		,return_date	
		,return_by
		,notes
	    ,@user_id
        ,GETDATE()
    FROM @tt
    WHERE warehousing_return_id IS NULL;

	RETURN @@IDENTITY;
END


