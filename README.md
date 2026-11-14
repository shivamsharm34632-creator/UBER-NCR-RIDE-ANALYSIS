# UBER-NCR-RIDE-ANALYSIS
Uber NCR ride booking analysis using PostgreSQL & Excel  with a dashboard.

# Problem Statement

This project analyses Uber ride bookings in the National Capital Region (NCR) for 2024. Using PostgreSQL and Excel, it examines:

- how booking volume and ride outcomes differ across vehicle types
- which times of day see the most completed rides
- which payment methods are used most
- how monthly revenue varies by vehicle type
- when customers and drivers cancel most often, and why
- why some rides end incomplete
- how customer and driver ratings compare across vehicle types

The goal is to understand demand patterns, ride completion and cancellation behaviour.

# Dataset

- Source: https://www.kaggle.com/datasets/yashdevladdha/uber-ride-analytics-dashboard
- Rows: 148767, covering 2024

# Tools used 
- Excel : data cleaning, pivot table, charts, dashboard
- PostgreSQL (pgAdmin) : analysis queries

# Data Cleaning

- The raw dataset contained 150000 booking records. During data cleaning 1233 ( 0.82% of total records) duplicate booking IDs were identified and removed.
- Replaced `null` text with blanks in number columns and `Not_Applicable` in text columns
- Removed quote marks from ID columns
- Time of day buckets: Morning 4-11, Afternoon 12-15, Evening 16-19, Night 20-3
- Earnings and revenue count completed rides only

# Business Questions and Insights

**Q1. What is the total booking volume and ride outcome distribution across vehicle types?**
Insight: Auto has the most bookings (37,093, about 25% of all bookings) and Uber XL the fewest (4,403, about 3%). Ride outcomes barely differ by vehicle type: about 62% of rides are completed and about 6% end incomplete for every type, with the rest cancelled or unmatched. Vehicle type affects how many rides are booked, not how likely a ride is to complete.

**Q2. During which time of the day do ride completions reach their highest volume?**
Insight: Morning has the most completed rides (28,848, about 31.3% of all completed rides), followed closely by Evening (27,043, about 29.3%). Night (19,421, about 21.1%) and Afternoon (16,924, about 18.3%) are lower. Time-of-day buckets differ in length (Morning and Night span 8 hours, Afternoon and Evening 4), so these are counts per bucket, not per hour.

**Q3. Which payment methods account for the most completed and incomplete rides?**
Insight: UPI leads both completed and incomplete rides. It accounts for 41,490 completed rides (about 45.0% of the total), 18,556 more than Cash (22,934, about 24.9%). It also has the most incomplete rides (4,048, about 45.2%). UPI's share is almost the same for completed and incomplete rides, so its lead reflects how widely it is used, not a higher chance of failure. Rides with no payment method (cancelled and unmatched) are excluded.

**Q4. How does total monthly revenue from completed rides vary across vehicle types?**
Insight: Auto earns the most revenue in every month, about 11.6M of the 46.9M total (24.8%), followed by Go Mini (9.3M, 19.9%) and Go Sedan (8.5M, 18.1%). Uber XL earns the least (1.4M, 3.0%). The ranking barely changes from month to month. Total monthly revenue stays between about 3.7M and 4.1M, highest in March (4.14M) and lowest in February (3.72M, the shortest month), so there is no strong seasonal pattern.

**Q5. At what time of day are customer cancellations most frequent, and why?**
Insight: Customer cancellations peak in the Morning (3,241, about 31.1% of 10,428) and Evening (3,065, about 29.4%), against Night (2,123) and Afternoon (1,999). Four reasons are almost equal overall: Wrong Address (2,343), Change of plans (2,335), Driver is not moving towards pickup location (2,319) and Driver asked to cancel (2,280), each about 22%. "AC is not working" is the least common (1,151, about 11%). No single reason stands out.

**Q6. At what time of day are driver cancellations most frequent, and why?**
Insight: Driver cancellations also peak in the Morning (8,282, about 31.0% of 26,755) and Evening (7,922, about 29.6%), followed by Night (5,565) and Afternoon (4,986). The four reasons are nearly equal, each about 25%: Customer related issue (6,780), The customer was coughing/sick (6,682), Personal & Car related issues (6,665) and More than permitted people in there (6,628). Drivers cancel about 2.6 times as often as customers (26,755 vs 10,428).

**Q7. How many trips ended as incomplete after pickup, and what are the leading causes?**
Insight:  8,946 rides ended incomplete after pickup. The causes are almost evenly split: Customer Demand (3,022, about 33.8%), Vehicle Breakdown (2,996, about 33.5%) and Other Issue (2,928, about 32.7%), so no single cause dominates.

**Q8. How do average customer and driver ratings compare across vehicle types?**
Insight: Ratings are almost identical across vehicle types. The average driver rating is 4.23 to 4.24 and the average customer rating is 4.40 to 4.41 for all seven types. Customer ratings are consistently about 0.17 higher than driver ratings, and vehicle type makes essentially no difference.

# Limitations

- Payment method is filled only for completed and incomplete rides
- Booking value and ratings are empty for rides that did not complete
- Time of day buckets differ in length, so figures are counts per bucket, not per hour
- Data covers 2024 only

# Files

- `sql/` : all analysis queries
- `excel/` : result sheets, charts and dashboard
- `images/` : dashboard screenshot
