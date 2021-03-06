

CREATE PROCEDURE [dbo].[product_type_upd]
(
    @tt    product_type_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  product_group_id	        = b.product_group_id
		    ,product_type_code		    = b.product_type_code
		    ,product_type_name		    = b.product_type_name
			,is_active					= b.is_active
            ,updated_by					= @user_id
            ,updated_date				= GETDATE()
     FROM dbo.product_type a INNER JOIN @tt b
        ON a.product_type_id = b.product_type_id 
       WHERE (
				isnull(a.product_group_id,0)		<> isnull(b.product_group_id,0)   
			OR	isnull(a.product_type_code,'')	    <> isnull(b.product_type_code,'')  
			OR	isnull(a.product_type_name,'')	    <> isnull(b.product_type_name,'')  
			OR	isnull(a.is_active,'')				<> isnull(b.is_active,'')   
	   )
	   
-- Insert Process
    INSERT INTO product_type (
         product_group_id 
		,product_type_code
		,product_type_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        product_group_id 
	   ,product_type_code
	   ,product_type_name
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE product_type_id IS NULL;

	--DECLARE @terminator INT = 1;
	--DECLARE @counter INT = (SELECT count(product_category_id) FROM dbo.product_category WHERE product_category_code is null);

	--WHILE @terminator <= @counter
	--	BEGIN
	--		UPDATE dbo.product_category
	--		SET product_category_code = (SELECT 'PC' + REPLICATE('0',4-LEN(RTRIM(product_category_id))) + RTRIM(product_category_id))
	--		WHERE product_category_id = (SELECT TOP 1 product_category_id FROM dbo.product_category WHERE product_category_code is null)

	--		SET @terminator = @terminator + 1;
	--	END
END



