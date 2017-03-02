

create PROCEDURE [dbo].[delivery_detail_sel]
(
      @delivery_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @delivery_id IS NOT NULL  
		SELECT * FROM dbo.delivery_detail WHERE delivery_id = @delivery_id; 

END
 







