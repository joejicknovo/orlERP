-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016
-- Description:	BOM to MRS select options
-- =============================================
CREATE PROCEDURE [dbo].[bom_sel_option]
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT bom_id, 
	   project_id
	FROM dbo.bom

END
