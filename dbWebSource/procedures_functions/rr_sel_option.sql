
-- =============================================
-- Author:		Rogelio T. Novo Jr.
-- Create date: October 13, 2016 11:51 PM
-- Description:	Project select option.
-- =============================================
CREATE PROCEDURE [dbo].[rr_sel_option]

AS
BEGIN
	SET NOCOUNT ON;

    SELECT receiving_item_id FROM dbo.receiving_item ORDER BY receiving_item_id DESC;

END


