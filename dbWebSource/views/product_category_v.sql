CREATE VIEW [dbo].[product_category_v]
AS
SELECT        TOP (100) PERCENT product_category_id, '(' + product_category_code + ') ' + product_category_name AS product_category, product_classification_id
FROM            dbo.product_category
ORDER BY product_classification_id, product_category

