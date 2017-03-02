

CREATE PROCEDURE [dbo].[product_image_upload_upd]
(
    @product_id INT,
    @image_filename VARCHAR(300)
)
AS

BEGIN
	SET NOCOUNT ON
--Update Process
     UPDATE dbo.product  
	 SET  image_url	= @image_filename
     WHERE product_id = @product_id
	
END



