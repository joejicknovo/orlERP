
CREATE FUNCTION [dbo].[getUnitOfMeasureCode](
	@unit_of_measure_id INT
) 
RETURNS VARCHAR(100) 
AS
BEGIN
   DECLARE @l_unit_of_measure_code VARCHAR(100); 

   SELECT @l_unit_of_measure_code = unit_of_measure_code 
   FROM dbo.unit_of_measure
   WHERE unit_of_measure_id = @unit_of_measure_id

   RETURN @l_unit_of_measure_code;
END;