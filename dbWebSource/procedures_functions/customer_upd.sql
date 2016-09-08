

CREATE PROCEDURE [dbo].[customer_upd]
(
    @tt    customer_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  customer_code		= b.customer_code
			,customer_name		= b.customer_name
			,contact_person		= b.contact_person
			,address			= b.address
			,mobile_no			= b.mobile_no
			,fox_no				= b.fox_no
			,office_no			= b.office_no
			,email_address		= b.email_address
			,is_active			= b.is_active
            ,updated_by			= @user_id
            ,updated_date		= GETDATE()
     FROM dbo.customer a INNER JOIN @tt b
        ON a.customer_id = b.customer_id 
       WHERE (
				isnull(a.customer_code,'')	<> isnull(b.customer_code,'')   
			OR	isnull(a.customer_name,'')	<> isnull(b.customer_name,'')   
			OR	isnull(a.contact_person,'') <> isnull(b.contact_person,'')
			OR	isnull(a.address,'')		<> isnull(b.address,'')
			OR  isnull(a.mobile_no,'')		<> isnull(b.mobile_no,'')
			OR	isnull(a.fox_no,'')			<> isnull(b.fox_no,'')
			OR  isnull(a.office_no,'')		<> isnull(b.office_no,'')
			OR  isnull(a.email_address,'')	<> isnull(b.email_address,'')
			OR	isnull(a.is_active,'')      <> isnull(b.is_active,'')   
	   )
	   
-- Insert Process

    INSERT INTO customer (
         customer_code 
		,customer_name
		,contact_person
		,address
		,mobile_no
		,fox_no
		,office_no
		,email_address
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        customer_code 
	   ,customer_name
	   ,contact_person
	   ,address
	   ,mobile_no
	   ,fox_no
	   ,office_no
	   ,email_address
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE customer_id IS NULL;
END




