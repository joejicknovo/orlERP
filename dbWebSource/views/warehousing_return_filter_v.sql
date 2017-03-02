CREATE VIEW [dbo].[warehousing_return_filter_v]
AS
SELECT        TOP (100) PERCENT warehousing_return_id, dbo.getProjectCodeName(project_id) AS project_name
FROM            dbo.warehousing_return
