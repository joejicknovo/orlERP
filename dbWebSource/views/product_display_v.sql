CREATE VIEW dbo.product_display_v
AS
SELECT        product_id, dbo.getProductCode(product_id) AS product_code, dbo.getProductName(product_id) AS product_name, dbo.getUnitOfMeasureCode(unit_of_measure_id) AS unit_of_measure_code, 
                         dbo.getClassificationName(product_classification_id) AS product_classification_name, dbo.getProductCategoryName(product_category_id) AS product_category_name, 
                         dbo.getProductGroupName(product_group_id) AS product_group_name, dbo.getProductTypeName(product_type_id) AS product_type_name, dbo.getProductBrandName(product_brand_id) AS product_brand_name, 
                         dbo.getProductAttributeValue(product_attribute_id) AS product_attribute_value, is_active, unit_of_measure_id, product_classification_id, product_category_id, product_group_id, product_type_id, 
                         product_brand_id, product_attribute_id
FROM            dbo.product
