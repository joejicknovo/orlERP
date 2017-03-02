CREATE VIEW [dbo].[product_type_v]
AS
SELECT        TOP (100) PERCENT product_type_id, '(' + product_type_code + ') ' + product_type_name AS product_type, product_group_id
FROM            dbo.product_type
ORDER BY product_group_id, product_type

