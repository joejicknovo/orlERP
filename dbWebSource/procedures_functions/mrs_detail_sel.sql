

CREATE PROCEDURE [dbo].[mrs_detail_sel]
(
      @mrs_id  INT = NULL
	 ,@user_id  int = null
)
AS
BEGIN

SET NOCOUNT ON

	IF @mrs_id IS NOT NULL  
		SELECT * FROM dbo.mrs_detail WHERE mrs_id = @mrs_id; 

END
 







