DROP TABLE IF EXISTS telecom_churn;
CREATE TABLE telecom_churn
(
CustomerID	INT,
CustomerName	TEXT,
Age	INT,
Gender	TEXT,
SeniorCitizen TEXT,	
MaritalStatus	TEXT,
Dependents	TEXT,
City	TEXT,
State_name	TEXT,
Country	TEXT,
JoinDate	TEXT,
TenureMonths	INT,
ContractType	TEXT,
Plan	TEXT,
InternetService TEXT,	
TechSupport	TEXT,
OnlineSecurity	TEXT,
DeviceProtection	TEXT,
StreamingTV	TEXT,
StreamingMovies	TEXT,
PaperlessBilling	TEXT,
PaymentMethod	TEXT,
MonthlyCharges	NUMERIC(10,2),
TotalCharges	NUMERIC(12,2),
NumSupportTickets	INT,
SatisfactionScore	INT,
AvgMonthlyGB	INT,
LatePayments	INT,
Churn TEXT
);

select * from telecom_churn;

-- Create staging table 
CREATE TABLE telecom_churn_staging (LIKE telecom_churn);

INSERT INTO telecom_churn_staging
SELECT * FROM telecom_churn;

SELECT * FROM telecom_churn_staging;

-- Data cleaning

-- Count rows
select COUNT(*) as total_rows from telecom_churn_staging;

-- Count columns
select COUNT(*) as total_columns from information_schema."columns" WHERE table_name = 'telecom_churn_staging';

-- Count total NULL (gender and total_charges have null values)
select
COUNT(CASE WHEN customername IS NULL THEN 1 END) as name_null,
COUNT(CASE WHEN age IS NULL THEN 1 END) as age_null,
COUNT(CASE WHEN gender IS NULL THEN 1 END) as gender_null,
COUNT(CASE WHEN seniorcitizen IS NULL THEN 1 END) as seniorcitizen_null,
COUNT(CASE WHEN maritalstatus IS NULL THEN 1 END) as maritalstatus_null,
COUNT(CASE WHEN dependents IS NULL THEN 1 END) as dependent_null,
COUNT(CASE WHEN city IS NULL THEN 1 END) as city_null,
COUNT(CASE WHEN state_name IS NULL THEN 1 END) as state_null,
COUNT(CASE WHEN country IS NULL THEN 1 END) as country_null,
COUNT(CASE WHEN joindate IS NULL THEN 1 END) as joindate_null,
COUNT(CASE WHEN tenuremonths IS NULL THEN 1 END) as tenuremonths_null,
COUNT(CASE WHEN contracttype IS NULL THEN 1 END) as contract_type_null,
COUNT(CASE WHEN plan IS NULL THEN 1 END) as plan_null,
COUNT(CASE WHEN internetservice IS NULL THEN 1 END) as internet_service_null,
COUNT(CASE WHEN techsupport IS NULL THEN 1 END) as techsupport_null,
COUNT(CASE WHEN onlinesecurity IS NULL THEN 1 END) as onlinesecurity_null,
COUNT(CASE WHEN deviceprotection IS NULL THEN 1 END) as device_protection_null,
COUNT(CASE WHEN streamingtv IS NULL THEN 1 END) as streamingtv_null,
COUNT(CASE WHEN streamingmovies IS NULL THEN 1 END) as streamingmovies_null,
COUNT(CASE WHEN paperlessbilling IS NULL THEN 1 END) as paperlessbilling_null,
COUNT(CASE WHEN paymentmethod IS NULL THEN 1 END) as payment_method_null,
COUNT(CASE WHEN monthlycharges IS NULL THEN 1 END) as monthlycharges_null,
COUNT(CASE WHEN totalcharges IS NULL THEN 1 END) as total_charges_null,
COUNT(CASE WHEN numsupporttickets IS NULL THEN 1 END) as support_ticket_null,
COUNT(CASE WHEN satisfactionscore IS NULL THEN 1 END) as satisfactionscore_null,
COUNT(CASE WHEN avgmonthlygb IS NULL THEN 1 END) as avgmonthlygb_null,
COUNT(CASE WHEN latepayments IS NULL THEN 1 END) as latepayment_null,
COUNT(CASE WHEN churn IS NULL THEN 1 END) as churn_null
from telecom_churn_staging;

-- Count '' or 'NULL' in any column

select COUNT(*) FILTER(WHERE TRIM(customername) = '' OR UPPER(TRIM(customername)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(gender) = '' OR UPPER(TRIM(gender)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(seniorcitizen) = '' OR UPPER(TRIM(seniorcitizen)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(maritalstatus) = '' OR UPPER(TRIM(maritalstatus)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(dependents) = '' OR UPPER(TRIM(dependents)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(city) = '' OR UPPER(TRIM(city)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(state_name) = '' OR UPPER(TRIM(state_name)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(country) = '' OR UPPER(TRIM(country)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(joindate) = '' OR UPPER(TRIM(joindate)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(contracttype) = '' OR UPPER(TRIM(contracttype)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(plan) = '' OR UPPER(TRIM(plan)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(internetservice) = '' OR UPPER(TRIM(internetservice)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(techsupport) = '' OR UPPER(TRIM(techsupport)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(onlinesecurity) = '' OR UPPER(TRIM(onlinesecurity)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(deviceprotection) = '' OR UPPER(TRIM(deviceprotection)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(streamingtv) = '' OR UPPER(TRIM(streamingtv)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(streamingmovies) = '' OR UPPER(TRIM(streamingmovies)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(paperlessbilling) = '' OR UPPER(TRIM(paperlessbilling)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(paymentmethod) = '' OR UPPER(TRIM(paymentmethod)) = 'NULL') from telecom_churn_staging;
select COUNT(*) FILTER(WHERE TRIM(churn) = '' OR UPPER(TRIM(churn)) = 'NULL') from telecom_churn_staging;

-- NULL in all columns
select * from telecom_churn_staging WHERE
customerid IS NULL AND
customername IS NULL AND
age IS NULL AND
gender IS NULL AND
seniorcitizen IS NULL AND
maritalstatus IS NULL AND
dependents IS NULL AND
city IS NULL AND
state_name IS NULL AND
country IS NULL AND
tenuremonths IS NULL AND
contracttype IS NULL AND
plan IS NULL AND
internetservice IS NULL AND
techsupport IS NULL AND
onlinesecurity IS NULL AND
deviceprotection IS NULL AND
streamingtv IS NULL AND
streamingmovies IS NULL AND
paperlessbilling IS NULL AND
paymentmethod IS NULL AND
monthlycharges IS NULL AND
totalcharges IS NULL AND
numsupporttickets IS NULL AND
satisfactionscore IS NULL AND
avgmonthlygb IS NULL AND
latepayments IS NULL AND
churn IS NULL AND
joindate IS NULL;

-- Identify and remove duplicates
SELECT
CustomerID,
CustomerName,	
Age	,
Gender,	
SeniorCitizen,
MaritalStatus,	
Dependents,
City,
State_name,	
Country,
JoinDate,	
TenureMonths,	
ContractType,	
Plan,
InternetService,	
TechSupport,
OnlineSecurity,	
DeviceProtection,	
StreamingTV,
StreamingMovies,	
PaperlessBilling,	
PaymentMethod,
MonthlyCharges,	
TotalCharges,
NumSupportTickets,	
SatisfactionScore,	
AvgMonthlyGB,
LatePayments,	
Churn,
COUNT(*) as duplicate_count
from telecom_churn_staging
GROUP BY
CustomerID,
CustomerName,	
Age	,
Gender,	
SeniorCitizen,
MaritalStatus,	
Dependents,
City,
State_name,	
Country,
JoinDate,	
TenureMonths,	
ContractType,	
Plan,
InternetService,	
TechSupport,
OnlineSecurity,	
DeviceProtection,	
StreamingTV,
StreamingMovies,	
PaperlessBilling,	
PaymentMethod,
MonthlyCharges,	
TotalCharges,
NumSupportTickets,	
SatisfactionScore,	
AvgMonthlyGB,
LatePayments,	
Churn
HAVING COUNT(*) > 1;

-- Total duplicates
select COUNT(*) from
(
SELECT *,
           COUNT(*) OVER (
               PARTITION BY
                   CustomerID,
                   CustomerName,
                   Age,
                   Gender,
                   SeniorCitizen,
                   MaritalStatus,
                   Dependents,
                   City,
                   State_Name,
                   Country,
                   JoinDate,
                   TenureMonths,
                   ContractType,
                   Plan,
                   InternetService,
                   TechSupport,
                   OnlineSecurity,
                   DeviceProtection,
                   StreamingTV,
                   StreamingMovies,
                   PaperlessBilling,
                   PaymentMethod,
                   MonthlyCharges,
                   TotalCharges,
                   NumSupportTickets,
                   SatisfactionScore,
                   AvgMonthlyGB,
                   LatePayments,
                   Churn
           ) AS dup_count
    FROM telecom_churn_staging
)t
WHERE dup_count>1;

-- Check if duplicates really exists
select * from telecom_churn_staging WHERE customerid=100814;
select * from telecom_churn_staging WHERE customerid=104944;
select * from telecom_churn_staging WHERE customerid=101402;
select * from telecom_churn_staging WHERE customerid=100782;
select * from telecom_churn_staging WHERE customerid=103103;


WITH duplicate_CTE AS
(
select *,
ROW_NUMBER() OVER(PARTITION BY CustomerID,CustomerName,Age,Gender,SeniorCitizen,MaritalStatus,Dependents,City,State_name,Country,JoinDate,TenureMonths,ContractType,Plan,InternetService,TechSupport,OnlineSecurity,DeviceProtection,StreamingTV,StreamingMovies,PaperlessBilling,PaymentMethod,MonthlyCharges,TotalCharges,NumSupportTickets,SatisfactionScore,AvgMonthlyGB,LatePayments,Churn) as rn
from telecom_churn_staging
)

select * from duplicate_CTE WHERE rn>1;

WITH duplicate_CTE AS
(
select ctid,
ROW_NUMBER() OVER(PARTITION BY CustomerID,CustomerName,Age,Gender,SeniorCitizen,MaritalStatus,Dependents,City,State_name,Country,JoinDate,TenureMonths,ContractType,Plan,InternetService,TechSupport,OnlineSecurity,DeviceProtection,StreamingTV,StreamingMovies,PaperlessBilling,PaymentMethod,MonthlyCharges,TotalCharges,NumSupportTickets,SatisfactionScore,AvgMonthlyGB,LatePayments,Churn) as rn
from telecom_churn_staging
)
delete from telecom_churn_staging WHERE ctid IN(select ctid from duplicate_CTE WHERE rn>1);

-- Check customerid
select DISTINCT customerid from telecom_churn_staging ORDER BY customerid;
alter table telecom_churn_staging ADD PRIMARY KEY(customerid);

-- Check customername
select DISTINCT customername from telecom_churn_staging ORDER BY customername NULLS FIRST;

select DISTINCT customername, INITCAP(TRIM(customername)) as clean_name from telecom_churn_staging;
update telecom_churn_staging set customername = INITCAP(TRIM(customername));

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% Md';
update telecom_churn_staging set customername = REPLACE(customername,' Md',' MD') WHERE customername LIKE '% Md'

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% MD';

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% Dds';
update telecom_churn_staging set customername = REPLACE(customername,' Dds',' DDS') WHERE customername LIKE '% Dds';
select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% Dvm'; 
update telecom_churn_staging set customername = REPLACE(customername,' Dvm',' DVM') WHERE customername LIKE '% Dvm';

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% DDS' OR customername LIKE '% DVM';

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% Phd';
update telecom_churn_staging set customername = REPLACE(customername,' Phd',' PhD') WHERE customername LIKE '% Phd';

select DISTINCT customerid,customername from telecom_churn_staging WHERE customername LIKE '% PhD';

-- Check age and create age_group column for better analysis
select DISTINCT age from telecom_churn_staging ORDER BY age NULLS FIRST; 

select * from telecom_churn_staging WHERE age IS NULL;
select * from telecom_churn_staging WHERE age < 18 OR age > 85;
select MAX(age),MIN(age) from telecom_churn_staging;

select *,
CASE
	WHEN age BETWEEN 18 AND 25 THEN '18-25'
	WHEN age BETWEEN 26 AND 35 THEN '26-35'
	WHEN age BETWEEN 36 AND 45 THEN '36-45'
	WHEN age BETWEEN 46 AND 55 THEN '46-55'
	WHEN age BETWEEN 56 AND 65 THEN '56-65'
	WHEN age BETWEEN 66 AND 75 THEN '66-75'
ELSE 'Above 75+'
END AS age_group
from telecom_churn_staging;

alter table telecom_churn_staging ADD column age_group TEXT;
update telecom_churn_staging set age_group = 
CASE
	WHEN age BETWEEN 18 AND 25 THEN '18-25'
	WHEN age BETWEEN 26 AND 35 THEN '26-35'
	WHEN age BETWEEN 36 AND 45 THEN '36-45'
	WHEN age BETWEEN 46 AND 55 THEN '46-55'
	WHEN age BETWEEN 56 AND 65 THEN '56-65'
	WHEN age BETWEEN 66 AND 75 THEN '66-75'
ELSE 'Above 75+'
END;

select * from telecom_churn_staging;

-- Check gender
select DISTINCT gender from telecom_churn_staging ORDER BY gender NULLS FIRST;

select COUNT(*) as total_nulls from telecom_churn_staging WHERE gender IS NULL; -- 836 nulls 
select gender, COALESCE(gender,'Unknown') as clean from telecom_churn_staging WHERE gender IS NULL;
update telecom_churn_staging set gender = 'Unknown' WHERE gender IS NULL;

update telecom_churn_staging set gender = TRIM(gender);

-- Check senior citizen
select DISTINCT seniorcitizen from telecom_churn_staging;
update telecom_churn_staging set seniorcitizen = TRIM(seniorcitizen);

-- Check marital status
select DISTINCT maritalstatus from telecom_churn_staging;
update telecom_churn_staging set maritalstatus = TRIM(maritalstatus);

-- Check dependents
select DISTINCT dependents from telecom_churn_staging;
update telecom_churn_staging set dependents = TRIM(dependents);

-- Check city, state_name and country
select DISTINCT city from telecom_churn_staging;
update telecom_churn_staging set city = INITCAP(TRIM(city));
select customerid,city, COUNT(*) as duplicate_count from telecom_churn_staging GROUP BY customerid,city HAVING COUNT(*) > 1;

select DISTINCT state_name from telecom_churn_staging;
update telecom_churn_staging set state_name = UPPER(TRIM(state_name));
select customerid,state_name, COUNT(*) as duplicate_count from telecom_churn_staging GROUP BY customerid,state_name HAVING COUNT(*) > 1;

select DISTINCT country from telecom_churn_staging;
update telecom_churn_staging set country = TRIM(country);

select DISTINCT city,state_name,country from telecom_churn_staging;

-- Check join date 
select DISTINCT joindate from telecom_churn_staging ORDER BY joindate NULLS FIRST;

-- 1. Check for invalid formats
select * from telecom_churn_staging
WHERE joindate IS NOT NULL
AND TRIM(joindate) <> ''
AND joindate !~ '^\d{4}-\d{2}-\d{2}$'
AND joindate !~ '^\d{2}/\d{2}/\d{4}$'
AND joindate !~ '^\d{2}-\d{2}-\d{4}$'

alter table telecom_churn_staging ADD COLUMN join_date DATE;

UPDATE telecom_churn_staging
SET join_date =
CASE
    WHEN joindate ~ '^\d{4}-\d{2}-\d{2}$'
        THEN TO_DATE(joindate,'YYYY-MM-DD')
    WHEN joindate ~ '^\d{2}/\d{2}/\d{4}$'
        THEN TO_DATE(joindate,'DD/MM/YYYY')
    WHEN joindate ~ '^\d{2}-\d{2}-\d{4}$'
        THEN TO_DATE(joindate,'MM-DD-YYYY')
    ELSE NULL
END;

select joindate, join_date from telecom_churn_staging;

alter table telecom_churn_staging DROP COLUMN joindate;
alter table telecom_churn_staging RENAME COLUMN join_date TO joindate;

select * from telecom_churn_staging;

-- Check tenuremonths
select DISTINCT tenuremonths from telecom_churn_staging ORDER BY tenuremonths NULLS FIRST;

-- Check contracttype
select DISTINCT contracttype from telecom_churn_staging ORDER BY contracttype NULLS FIRST;
update telecom_churn_staging set contracttype = TRIM(contracttype);

-- Check plan
select DISTINCT plan from telecom_churn_staging ORDER BY plan NULLS FIRST;

select COUNT(*) from telecom_churn_staging WHERE plan = 'basic'; --370
select COUNT(*) from telecom_churn_staging WHERE plan = 'Basic'; --1329
update telecom_churn_staging set plan = 'Basic' WHERE plan = 'basic';

select COUNT(*) from telecom_churn_staging WHERE plan = 'premium'; --332
select COUNT(*) from telecom_churn_staging WHERE plan = 'Premium'; --1287
update telecom_churn_staging set plan = 'Premium' WHERE plan = 'premium';

select COUNT(*) from telecom_churn_staging WHERE plan = 'standard'; --336
select COUNT(*) from telecom_churn_staging WHERE plan = 'Standard'; --1346
update telecom_churn_staging set plan = 'Standard' WHERE plan = 'standard';

update telecom_churn_staging set plan = TRIM(plan);

-- Check internet service
select DISTINCT internetservice from telecom_churn_staging ORDER BY internetservice NULLS FIRST;
update telecom_churn_staging set internetservice = TRIM(internetservice);

-- Check tech support
select DISTINCT techsupport from telecom_churn_staging;
update telecom_churn_staging set techsupport = TRIM(techsupport);

-- Check online security
select DISTINCT onlinesecurity from telecom_churn_staging;
update telecom_churn_staging set onlinesecurity = TRIM(onlinesecurity);

-- Check device protection
select DISTINCT deviceprotection from telecom_churn_staging;
update telecom_churn_staging set deviceprotection = TRIM(deviceprotection);

-- Check streaming tv
select DISTINCT streamingtv from telecom_churn_staging;
update telecom_churn_staging set streamingtv = TRIM(streamingtv);

-- Check streaming movies
select DISTINCT streamingmovies from telecom_churn_staging;
update telecom_churn_staging set streamingmovies = TRIM(streamingmovies);

-- Check paperless billing
select DISTINCT paperlessbilling from telecom_churn_staging;
update telecom_churn_staging set paperlessbilling = TRIM(paperlessbilling);

-- Check payment method
select DISTINCT paymentmethod from telecom_churn_staging;
update telecom_churn_staging set paymentmethod = TRIM(paymentmethod);

-- Check monthly and total charges
select COUNT(*) from telecom_churn_staging WHERE monthlycharges IS NULL;
select COUNT(*) from telecom_churn_staging WHERE totalcharges IS NULL;

select * from telecom_churn_staging WHERE monthlycharges < 0;
select * from telecom_churn_staging WHERE totalcharges < 0;

select MIN(monthlycharges) as "Miniumum monthly charge", MAX(monthlycharges) as "Maximum monthly charge" from telecom_churn_staging;
select MIN(totalcharges) as "Miniumum total charge", MAX(totalcharges) as "Maximum total charge" from telecom_churn_staging;

select DISTINCT monthlycharges from telecom_churn_staging WHERE monthlycharges <> ROUND(monthlycharges,2);
select DISTINCT totalcharges from telecom_churn_staging WHERE totalcharges <> ROUND(totalcharges,2);

select DISTINCT totalcharges from telecom_churn_staging ORDER BY totalcharges NULLS FIRST;
select customerid,customername,age,gender,city,state_name,country,monthlycharges,joindate from telecom_churn_staging WHERE totalcharges IS NULL;

-- Check number of support tickets
select DISTINCT numsupporttickets from telecom_churn_staging ORDER BY numsupporttickets NULLS FIRST;

-- Check satisfaction score
select DISTINCT satisfactionscore from telecom_churn_staging ORDER BY satisfactionscore NULLS FIRST;

-- Check avg monthly gb
select DISTINCT avgmonthlygb from telecom_churn_staging ORDER BY avgmonthlygb NULLS FIRST;

select avgmonthlygb,
CASE
	WHEN avgmonthlygb BETWEEN 0 AND 50 THEN 'Low usage'
	WHEN avgmonthlygb BETWEEN 51 AND 300 THEN 'Medium usage'
	WHEN avgmonthlygb BETWEEN 301 AND 600 THEN 'High usage'
	ELSE 'Very High usage'
END as usage_group
from telecom_churn_staging;

alter table telecom_churn_staging ADD column usage_group TEXT;
update telecom_churn_staging set usage_group =
CASE
	WHEN avgmonthlygb BETWEEN 0 AND 50 THEN 'Low usage'
	WHEN avgmonthlygb BETWEEN 51 AND 300 THEN 'Medium usage'
	WHEN avgmonthlygb BETWEEN 301 AND 600 THEN 'High usage'
	ELSE 'Very High usage'
END;

select * from telecom_churn_staging;

-- Check late payments
select DISTINCT latepayments from telecom_churn_staging ORDER BY latepayments NULLS FIRST;

-- check Churn
select DISTINCT churn from telecom_churn_staging ORDER BY churn NULLS FIRST;
update telecom_churn_staging set churn = TRIM(churn);

-- View final cleaned table
select * from telecom_churn_staging ORDER BY customerid;

-- Create a view to present Business KPI's and answer Business questions

CREATE VIEW telecom_churn_view AS
SELECT 
customerid,
customername,
age,
age_group,
gender,
seniorcitizen,
maritalstatus,
dependents,
city,
state_name,
country,
joindate,
tenuremonths,
contracttype,
plan,
internetservice,
techsupport,
onlinesecurity,
deviceprotection,
streamingtv,
streamingmovies,
paperlessbilling,
paymentmethod,
monthlycharges,
totalcharges,
numsupporttickets,
satisfactionscore,
avgmonthlygb,
usage_group,
latepayments,
churn
FROM telecom_churn_staging;

select * from telecom_churn_view;

select COUNT(*) as total_rows from telecom_churn_view;
select COUNT(*) as total_columns from information_schema."columns" WHERE table_name = 'telecom_churn_view';

-- ********** KPI (Key Performance Indicators) **************

-- (1) Total Customers
select COUNT(customerid) as "Total Customers" from telecom_churn_view;
-- (2) Active Customers
select COUNT(customerid) as "Active Customers" from telecom_churn_view WHERE churn = 'No';
-- (3) Churned Customers
select COUNT(customerid) as "Churned Customers" from telecom_churn_view WHERE churn = 'Yes';
-- (4) Churn Rate (%)
select ROUND(COUNT(*) FILTER(WHERE churn='Yes') *100.0 /COUNT(*),2) as "Churn Rate (%)" from telecom_churn_view;
-- (5) Retention Rate (%)
select ROUND(COUNT(*) FILTER(WHERE churn='No') * 100.0/COUNT(*),2) as "Retention Rate (%)" from telecom_churn_view;
-- (6) Total Revenue
select COALESCE(SUM(totalcharges),0) as "Total Revenue" from telecom_churn_view;
-- (7) Average Monthly Charges
select ROUND(AVG(monthlycharges),2) as "Average Monthly Charges" from telecom_churn_view;
-- (8) Average Tenure 
select ROUND(AVG(tenuremonths),2) as "Average Tenure" from telecom_churn_view;
-- (9) Average Satisfaction Score
select ROUND(AVG(satisfactionscore),2) as "Average Satisfaction Score" from telecom_churn_view;
-- (10) Average Support Tickets per Customer
select ROUND(AVG(numsupporttickets),2) as "Support tickets per customer" from telecom_churn_view

-- ***************** Business Questions and Insights **********************

select * from telecom_churn_view;

-- 1.	What is the overall customer churn rate?
select CONCAT(ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2),'%') as "Overall churn rate" from telecom_churn_view;

-- 2.	Which contract type has the highest customer churn rate?
WITH Customerchurnrate_cte AS
(
select contracttype, ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate from telecom_churn_view
GROUP BY contracttype
)
select contracttype, CONCAT(churnrate,'%') from Customerchurnrate_cte 
ORDER BY churnrate DESC
LIMIT 1;

-- 3.	Which subscription plans have the highest customer churn rate?
WITH Customerchurnrate_cte AS
(
select plan, ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate from telecom_churn_view
GROUP BY plan
)
select plan, CONCAT(churnrate,'%') from Customerchurnrate_cte 
ORDER BY churnrate DESC
LIMIT 1;

-- 4. Which cities have a churn rate higher than the overall company churn rate?
WITH Churn_CTE AS
(
select city,ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate
from telecom_churn_view GROUP BY city 
)
select city, CONCAT(churnrate,'%') from Churn_CTE WHERE churnrate > (select ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) from telecom_churn_view)
ORDER BY churnrate DESC;

-- 5.	Which age group experiences the highest churn rate?
WITH age_group_churncte AS
(
select age_group,ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate,
DENSE_RANK() OVER(ORDER BY ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) DESC) rn
from telecom_churn_view
GROUP BY age_group
)
select age_group,CONCAT(churnrate,'%') as churnrate from age_group_churncte WHERE rn=1;

-- 6.	Does customer satisfaction score impact churn?
WITH satisfactionscore_CTE AS
(
select satisfactionscore,COUNT(*) as total_customers, COUNT(*) FILTER(WHERE churn='Yes') as churned_customers, ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate
from telecom_churn_view
GROUP BY satisfactionscore
)
select * from satisfactionscore_CTE
ORDER BY satisfactionscore;

-- 7.	Are customers with a higher number of support tickets more likely to churn?
WITH SupportTicket_CTE AS
(
select numsupporttickets,
COUNT(*) as total_customers,
COUNT(*) FILTER(WHERE churn='Yes') as churned_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate
from telecom_churn_view
GROUP BY numsupporttickets
)
select * from SupportTicket_CTE
ORDER BY numsupporttickets DESC;

-- 8.	Does the number of late payments increase the likelihood of customer churn?
WITH Latepayment_CTE AS
(
select latepayments,
COUNT(*) as total_customers,
COUNT(*) FILTER(WHERE churn='Yes') as churned_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate
from telecom_churn_view
GROUP BY latepayments
)
select * from Latepayment_CTE
ORDER BY latepayments DESC;

-- 9.	Which payment method has the highest churn rate?
WITH Paymentmethod_CTE AS
(
select paymentmethod,
COUNT(*) as total_customers,
COUNT(*) FILTER(WHERE churn='Yes') as churned_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate
from telecom_churn_view
GROUP BY paymentmethod
)
select * from Paymentmethod_CTE
ORDER BY churnrate DESC
LIMIT 1;

-- 10.	Which subscription plans generate the highest total revenue?
WITH Subscriptionplan_CTE AS
(
select plan,
SUM(totalcharges) as total_revenue,
DENSE_RANK() OVER(ORDER BY SUM(totalcharges) DESC) as rn from telecom_churn_view
GROUP BY plan
)
select plan as "Subscription plan",total_revenue as "Total revenue" from Subscriptionplan_CTE WHERE rn=1;

-- 11.	Which states and cities contribute the highest total revenue?
select state_name,city,
COALESCE(SUM(totalcharges),0) as total_revenue from telecom_churn_view
GROUP BY state_name,city
ORDER BY total_revenue DESC;

-- 12.	What is the Average Revenue Per Customer (ARPU)?
select ROUND(SUM(totalcharges)/COUNT(customerid),2) as "Average revenue" from telecom_churn_view;

-- 13.	Who are the top 10 highest-value customers based on total revenue generated?
WITH Top10_customer AS
(
select customerid, customername,COALESCE(SUM(totalcharges),0) as total_revenue,
DENSE_RANK() OVER(ORDER BY COALESCE(SUM(totalcharges),0) DESC) as rn
from telecom_churn_view
GROUP BY customerid, customername
)
select customerid as "Customer ID",customername as "Customer Name",total_revenue as "Total revenue" 
from Top10_customer WHERE rn<=10;

-- 14.	Which customer segments (based on contract type and plan) generate the highest revenue?
WITH Customersegment_CTE AS
(
select contracttype,plan,COALESCE(SUM(totalcharges),0) as total_revenue,
DENSE_RANK() OVER(ORDER BY COALESCE(SUM(totalcharges),0) DESC) as rn
from telecom_churn_view
GROUP BY contracttype,plan
)
select contracttype as "Contract Type",plan as "Subscription plan",total_revenue as "Total revenue"
from Customersegment_CTE WHERE rn=1;

-- 15.	What percentage of customers subscribe to each internet service type?
select internetservice as "Internet service",COUNT(*) as "Total customers",
CONCAT(ROUND(COUNT(*) *100.0/(select COUNT(*) from telecom_churn_view),2),'%') as "Customer (%)" from telecom_churn_view
GROUP BY internetservice;

-- 16.	How has customer acquisition changed over the years based on join date?
select EXTRACT(YEAR FROM joindate) as year,EXTRACT(MONTH FROM joindate) as month, TO_CHAR(joindate,'FMMonth') as month_name,
COUNT(*) as customers_acquired
from telecom_churn_view
GROUP BY EXTRACT(YEAR FROM joindate),EXTRACT(MONTH FROM joindate),TO_CHAR(joindate,'FMMonth')
ORDER BY year,month;

-- 17.	Which regions should be prioritized for customer retention campaigns based on churn rate?
select state_name,
COUNT(*) as total_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) as churnrate from telecom_churn_view
GROUP BY state_name
ORDER BY churnrate DESC;

-- 18.	Find the top 3 revenue-generating customers in each state.
WITH Top3customer_CTE AS
(
select customerid, customername, state_name,COALESCE(SUM(totalcharges),0) as total_revenue,
DENSE_RANK() OVER(PARTITION BY state_name ORDER BY COALESCE(SUM(totalcharges),0) DESC) as rn
from telecom_churn_view
GROUP BY customerid, customername, state_name
)
select customerid as "Customer ID", customername as "Customer Name", state_name as "State",total_revenue as "Total revenue"
from Top3customer_CTE
WHERE rn<=3;

-- 19.	Compare the average monthly charges of each plan with the overall average monthly charge.
WITH Averagemonthlycharge_CTE AS
(
select plan,ROUND(AVG(monthlycharges),2) as avg_monthlycharge from telecom_churn_view
GROUP BY plan
)
select plan,avg_monthlycharge,
(select ROUND(AVG(monthlycharges),2) from telecom_churn_view) as overall_monthlycharge,
CASE
	WHEN avg_monthlycharge > (select ROUND(AVG(monthlycharges),2) from telecom_churn_view) THEN 'Above average'
ELSE 'Below average'
END as monthly_charge_comparison
from Averagemonthlycharge_CTE 
ORDER BY avg_monthlycharge DESC;

-- 20.	Rank customers within each contract type based on their Total Charges.
WITH CustomerRank_CTE AS
(
select customerid,customername,contracttype,COALESCE(totalcharges,0) as totalcharges,
DENSE_RANK() OVER(PARTITION BY contracttype ORDER BY COALESCE(totalcharges,0) DESC) as rank_customer
from telecom_churn_view
)
select * from CustomerRank_CTE
