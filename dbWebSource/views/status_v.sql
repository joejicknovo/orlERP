CREATE VIEW [dbo].[status_v]
AS
SELECT        TOP (100) PERCENT dbo.status.status_id, dbo.status.status_category_id, dbo.status_category.status_category_description, dbo.status.status_code, dbo.status.status_name, dbo.status.is_active
FROM            dbo.status_category RIGHT OUTER JOIN
                         dbo.status ON dbo.status_category.status_category_id = dbo.status.status_category_id
WHERE        (dbo.status.is_active = 'Y')
ORDER BY dbo.status_category.status_category_description, dbo.status.status_name

