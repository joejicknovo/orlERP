CREATE PROCEDURE [dbo].[unit_of_measure_sel]
(
    @unit_of_measure_id  INT = null
)
AS
BEGIN

SET NOCOUNT ON

  IF @unit_of_measure_id IS NOT NULL  
	 SELECT * 
	 FROM dbo.unit_of_measure 
	 WHERE unit_of_measure_id = @unit_of_measure_id
	 ORDER BY unit_of_measure_name; 
  ELSE
      SELECT * FROM dbo.unit_of_measure
	  ORDER BY unit_of_measure_name; 
	
END
 
