CREATE VIEW [dbo].[product_group_v]
AS
SELECT        TOP (100) PERCENT product_group_id, '(' + product_group_code + ') ' + product_group_name AS product_group, product_category_id
FROM            dbo.product_group
ORDER BY product_category_id, product_group

