CREATE PROCEDURE [dbo].[product_group_upd]
(
    @tt    product_group_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
     UPDATE a 
        SET  product_category_id    = b.product_category_id
		    ,product_group_code     = b.product_group_code
			,product_group_name		= b.product_group_name
			,is_active				= b.is_active
            ,updated_by				= @user_id
            ,updated_date			= GETDATE()
     FROM dbo.product_group a INNER JOIN @tt b
        ON a.product_group_id = b.product_group_id 
     WHERE (
				ISNULL(a.product_category_id,0)		<> ISNULL(b.product_category_id,0)   
			 OR ISNULL(a.product_group_code,'')		<> ISNULL(b.product_group_code,'')
			 OR ISNULL(a.product_group_name,'')		<> ISNULL(b.product_group_name,'')
			 OR ISNULL(a.is_active,'')				<> ISNULL(b.is_active,'')
	   );

-- Insert Process
	--DECLARE @product_group_id INT = NULL;
    INSERT INTO product_group (
         product_category_id
		,product_group_code
		,product_group_name
		,is_active 
        ,created_by
        ,created_date
        )
    SELECT 
        product_category_id
	   ,product_group_code
	   ,product_group_name
	   ,is_active 
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE product_group_id IS NULL;

--Code generator
 --   DECLARE @terminator INT = 1;
	--DECLARE @counter INT = (SELECT COUNT(product_group_id) FROM dbo.product_group WHERE product_group_code IS NULL);

	--WHILE @terminator <= @counter
	--	BEGIN
	--		UPDATE dbo.product_group
	--		SET product_group_code = (SELECT 'PG' + REPLICATE('0',4-LEN(RTRIM(product_group_id))) + RTRIM(product_group_id))
	--		WHERE product_group_id = (SELECT TOP 1 product_group_id FROM dbo.product_group WHERE product_group_code IS NULL);

	--		SET @terminator = @terminator + 1;
	--	END

END


  






