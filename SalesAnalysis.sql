'''
Write an SQL query that reports the products that were only sold in spring 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
'''

select product_id, product_name
from Product
where product_id in 
(SELECT t1.product_id
FROM 
(select product_id
from Sales 
where sale_date >= "2019-01-01" and sale_date <= "2019-03-31") t1
LEFT JOIN 
(select product_id
from Sales 
where sale_date < "2019-01-01" or sale_date > "2019-03-31") t2 
ON t2.product_id = t1.product_id
WHERE t2.product_id IS NULL
)
