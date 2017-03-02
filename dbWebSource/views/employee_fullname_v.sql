CREATE VIEW [dbo].[employee_fullname_v]
AS
SELECT        TOP (100) PERCENT employee_id, employee_first_name + ' ' + employee_middle_name + ' ' + employee_last_name AS employee_fullname, status_id, position_id
FROM            dbo.employee
WHERE        (status_id <> 23)
ORDER BY employee_fullname
