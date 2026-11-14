-- Q.1) What is the total booking volume and ride outcome distribution across different vehicle types?

SELECT vehicle_type ,COUNT(booking_id) AS total_bookings,
CONCAT(ROUND(100.0*SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END)/COUNT(*),2),'%') AS completed_rides,
CONCAT(ROUND(100.0*SUM(CASE WHEN booking_status = 'Incomplete' THEN 1 ELSE 0  END )/COUNT(*),2),'%') AS incomplete_rides,
CONCAT(ROUND(100.0*SUM(CASE WHEN booking_status = 'Cancelled by Customer'  THEN 1 ELSE 0  END )/COUNT(*),2),'%') AS customer_cancelled,
CONCAT(ROUND(100.0*SUM(CASE WHEN booking_status = 'Cancelled by Driver' THEN 1 ELSE 0  END )/COUNT(*),2),'%') AS driver_cancelled,
CONCAT(ROUND(100.0*SUM(CASE WHEN booking_status = 'No Driver Found' THEN 1 ELSE  0  END )/COUNT(*),2),'%') AS no_driver_found
FROM NCR_UBER_RIDE_DETAILS
GROUP BY vehicle_type;

--Q.2) During which time of the day do ride completions reach their highest volume?

SELECT 
CASE WHEN EXTRACT( HOUR FROM time ) BETWEEN 4 AND 11 THEN 'MORNING' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 12 AND 15 THEN 'AFTERNOON' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 16 AND 19 THEN 'EVENING' 
 ELSE 'NIGHT' END AS time_of_the_day,
SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_rides
FROM NCR_UBER_RIDE_DETAILS
GROUP BY time_of_the_day
ORDER BY completed_rides DESC;

--Q.3) Which payment methods account for the highest share of completed and incomplete rides?

SELECT payment_method,
SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_rides,
SUM(CASE WHEN booking_status = 'Incomplete' THEN 1 ELSE 0  END ) AS incomplete_rides
FROM NCR_UBER_RIDE_DETAILS 
WHERE payment_method != 'Not_Applicable'
GROUP BY payment_method
ORDER BY completed_rides DESC;
 
--Q.4) How does total monthly revenue from completed rides vary across each vehicle category?

SELECT EXTRACT(MONTH FROM date) AS month,vehicle_type,SUM(booking_value) AS total_earning 
FROM NCR_UBER_RIDE_DETAILS
WHERE booking_status ='Completed'
GROUP BY vehicle_type ,EXTRACT(MONTH FROM date)
ORDER BY month ASC,total_earning DESC;

--Q.5) At what time of day are customer cancellations most frequent, and what are the primary reasons behind them?

SELECT
CASE WHEN EXTRACT( HOUR FROM time ) BETWEEN 4 AND 11 THEN 'MORNING' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 12 AND 15 THEN 'AFTERNOON' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 16 AND 19 THEN 'EVENING' 
 ELSE 'NIGHT' END AS time_of_the_day,
SUM(CASE WHEN booking_status = 'Cancelled by Customer'  THEN 1 ELSE 0  END ) AS customer_cancelled,
Reason_for_cancelling_by_Customer
FROM NCR_UBER_RIDE_DETAILS
WHERE Reason_for_cancelling_by_Customer != 'Not_Applicable' 
GROUP BY time_of_the_day,Reason_for_cancelling_by_Customer
ORDER BY 
CASE WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 4 AND 11  THEN 1
 WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 12 AND 15 THEN 2
 WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 16 AND 19  THEN 3
 ELSE 4 END ASC,customer_cancelled DESC;

--Q.6) At what time of day are driver cancellations most frequent, and what are the primary reasons behind them?

SELECT
CASE WHEN EXTRACT( HOUR FROM time ) BETWEEN 4 AND 11 THEN 'MORNING' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 12 AND 15 THEN 'AFTERNOON' 
 WHEN EXTRACT( HOUR FROM time ) BETWEEN 16 AND 19 THEN 'EVENING' 
 ELSE 'NIGHT' END AS time_of_the_day,
SUM(CASE WHEN booking_status = 'Cancelled by Driver'  THEN 1 ELSE 0  END ) AS driver_cancelled,
driver_cancellation_reason
FROM NCR_UBER_RIDE_DETAILS
WHERE driver_cancellation_reason != 'Not_Applicable' 
GROUP BY time_of_the_day,driver_cancellation_reason
ORDER BY 
CASE WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 4 AND 11  THEN 1
 WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 12 AND 15 THEN 2
 WHEN EXTRACT( HOUR FROM MIN(time) ) BETWEEN 16 AND 19  THEN 3
 ELSE 4 END ASC,driver_cancelled DESC;

--Q.7) How many trips ended as incomplete after pickup, and what are the leading causes?

SELECT Incomplete_Rides_Reason, COUNT(*) AS total_incomplete_rides
FROM NCR_UBER_RIDE_DETAILS
WHERE Incomplete_Rides_Reason != 'Not_Applicable'
GROUP BY Incomplete_Rides_Reason
ORDER BY  total_incomplete_rides DESC;

--Q.8) How do average customer and driver ratings compare across all vehicle types?

SELECT vehicle_type,
ROUND(AVG(Driver_Ratings)::numeric,2) AS avg_driver_rating,
ROUND(AVG(Customer_Rating)::numeric,2) AS avg_customer_rating
FROM NCR_UBER_RIDE_DETAILS
GROUP BY  vehicle_type;