'''
You want to know how long a user visits your application. You decided to create bins of 
"[0-5>", "[5-10>", "[10-15>" and "15 minutes or more" and count the number of sessions on it.

Write an SQL query to report the (bin, total) in any order.
'''

select b.bin, ifnull(count(s.bin),0) as total
from 
(select session_id, 
case when duration<300 then "[0-5>"
     when duration>=300 and duration<600 then "[5-10>"
     when duration>=600 and duration<900 then "[10-15>"
     when duration>=900 then "15 or more" end as bin
from Sessions) s
right join
(select "[0-5>" as bin
union
select "[5-10>" as bin
union
select "[10-15>" as bin
union
select "15 or more" as bin) b
on b.bin=s.bin
group by b.bin
