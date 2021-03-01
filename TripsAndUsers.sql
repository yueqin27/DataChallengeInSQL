'''
Write a SQL query to find the cancellation rate of requests with unbanned users each day between "2013-10-01" and "2013-10-03".

The cancellation rate is computed by dividing the number of canceled requests with unbanned users by the total number of requests with unbanned users on that day.
'''


select Trips.Request_at Day,
ROUND(SUM(CASE WHEN Trips.Status="cancelled_by_driver" or Trips.Status="cancelled_by_client" THEN 1 ELSE 0 END)/COUNT(Trips.Status),2) "Cancellation Rate"
from Trips
where Trips.Client_Id not in (select Users_id from Users where Banned='Yes') and
      Trips.Driver_Id not in (select Users_id from Users where Banned='Yes') and 
      Trips.Request_at between "2013-10-01" and "2013-10-03"
group by Trips.Request_at
