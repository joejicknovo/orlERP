
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 11:48 PM
-- Description:	Project select option.
-- =============================================
CREATE PROCEDURE [dbo].[project_sel_option]

AS
BEGIN
	SET NOCOUNT ON;

    SELECT project_id, project_name FROM dbo.project ORDER BY project_id DESC;

END


