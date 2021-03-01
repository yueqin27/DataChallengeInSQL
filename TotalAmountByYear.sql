'''
Write an SQL query to report the Total sales amount of each item for each year, with corresponding product name, product_id, product_name and report_year.

Dates of the sales years are between 2018 to 2020. Return the result table ordered by product_id and report_year.
'''

with tmp as ((select product_id, "2018" as report_year, 
(DATEDIFF(LEAST(period_end,"2018-12-31"),GREATEST(period_start,"2018-01-01"))+1) * average_daily_sales as total_amount
from Sales
where YEAR(period_start) = "2018" or YEAR(period_end) = "2018")

union all

(select product_id, "2019" as report_year, 
(DATEDIFF(LEAST(period_end,"2019-12-31"),GREATEST(period_start,"2019-01-01"))+1) * average_daily_sales as total_amount
from Sales
where YEAR(period_start) <= "2019" and YEAR(period_end) >= "2019")

union all

(select product_id, "2020" as report_year, 
(DATEDIFF(LEAST(period_end,"2020-12-31"),GREATEST(period_start,"2020-01-01"))+1) * average_daily_sales as total_amount
from Sales
where YEAR(period_start) = "2020" or YEAR(period_end) = "2020"))


select t.product_id, p.product_name, t.report_year, t.total_amount
from tmp t
join Product p on t.product_id = p.product_id
order by t.product_id, t.report_year

