CREATE VIEW [dbo].[delivery_project_filter_v]
AS
SELECT        delivery_id, dbo.getProjectCodeName(project_id) AS project_name
FROM            dbo.delivery
