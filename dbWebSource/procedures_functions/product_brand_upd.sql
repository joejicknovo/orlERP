
CREATE PROCEDURE [dbo].[product_brand_upd]
(
    @tt    product_brand_tt READONLY
   ,@user_id int
)
AS

BEGIN
-- Update Process
    UPDATE a 
        SET  product_brand_code  = b.product_brand_code
			,product_brand_name	 = b.product_brand_name
			,is_active			 = b.is_active
            ,updated_by			 = @user_id
            ,updated_date		 = GETDATE()
    FROM dbo.product_brand a INNER JOIN @tt b
        ON a.product_brand_id = b.product_brand_id 
    WHERE ( isnull(a.product_brand_name,'') <> isnull(b.product_brand_name,''))

-- Insert Process
    INSERT INTO product_brand (
	     product_brand_code
        ,product_brand_name
		,is_active
        ,created_by
        ,created_date
        )
    SELECT 
        product_brand_code
	   ,product_brand_name
	   ,is_active
       ,@user_id
       ,GETDATE()
    FROM @tt
    WHERE product_brand_id IS NULL
END


