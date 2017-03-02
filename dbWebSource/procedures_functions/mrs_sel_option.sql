-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 10:25 PM
-- Description:	MRS select option.
-- =============================================
CREATE PROCEDURE [dbo].[mrs_sel_option]
	
AS
BEGIN
	SET NOCOUNT ON;

    SELECT mrs_id, project_id FROM dbo.mrs
END


