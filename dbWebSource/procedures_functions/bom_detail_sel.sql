
CREATE PROCEDURE [dbo].[bom_detail_sel]
(
      @bom_id  INT = NULL
)
AS
BEGIN

SET NOCOUNT ON

	IF @bom_id IS NOT NULL  
		SELECT * FROM dbo.bom_detail WHERE bom_id = @bom_id; 

END
