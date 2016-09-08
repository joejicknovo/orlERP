
CREATE PROCEDURE [dbo].[warehouse_upd]
(
    @tt    warehouse_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  warehouse_code					= b.warehouse_code
			,warehouse_name					= b.warehouse_name
			,warehouse_location				= b.warehouse_location
			,warehouse_address				= b.warehouse_address
			,warehouse_contact_no			= b.warehouse_contact_no
			,warehouse_contact_person_id	= b.warehouse_contact_person_id
			,is_active						= b.is_active
            ,updated_by						= @user_id
            ,updated_date					= GETDATE()
		FROM dbo.warehouse a INNER JOIN @tt b
        ON a.warehouse_id = b.warehouse_id 
		WHERE (
				isnull(a.warehouse_code,'')					<> isnull(b.warehouse_code,'')   
			OR	isnull(a.warehouse_name,'')					<> isnull(b.warehouse_name,'')   
			OR	isnull(a.warehouse_location,'')				<> isnull(b.warehouse_location,'')   
			OR	isnull(a.warehouse_address,'')				<> isnull(b.warehouse_address,'')   
			OR	isnull(a.warehouse_contact_no,'')			<> isnull(b.warehouse_contact_no,'')   
			OR	isnull(a.warehouse_contact_person_id,0)	<> isnull(b.warehouse_contact_person_id,0)   
			OR	isnull(a.is_active,'')						<> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO dbo.warehouse (
         warehouse_code 
		,warehouse_name
		,warehouse_location
		,warehouse_address
		,warehouse_contact_no
		,warehouse_contact_person_id
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        warehouse_code 
	   ,warehouse_name	
	   ,warehouse_location
	   ,warehouse_address
	   ,warehouse_contact_no
	   ,warehouse_contact_person_id
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE warehouse_id IS NULL;
END




