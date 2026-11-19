# Bank Customer Transaction Analysis

## Business Problem
Banks process thousands of transactions every day. This project analyses how customers transact, which groups spend the most, and which transactions look unusual, so a bank can improve its services and monitor risk.

## Dataset
- **Source:** Bank transactions dataset from Kaggle (likely synthetic)
- **Size:** 2,512 transactions, 16 columns
- **Key columns:** TransactionAmount, TransactionDate, TransactionType, Channel, Location, CustomerAge, CustomerOccupation, LoginAttempts, AccountBalance

## Tools Used
- **Python:** pandas, numpy, matplotlib, seaborn (cleaning, analysis, charts)
- **SQL:** PostgreSQL with pgAdmin (aggregations, window functions, CTE, CASE WHEN)
- **Jupyter Notebook** in VS Code

## Data Cleaning
- Checked for missing values and duplicate rows: none found.
- Converted `TransactionDate` and `PreviousTransactionDate` from text to datetime.
- Created new columns: `Month`, `DayOfWeek` and `AgeGroup` (18-30, 31-45, 46-60, 60+).
- Saved the cleaned data as `bank_transactions_clean.csv`.

## Python Insights
1. **Debit transactions dominate:** 1,944 debit (77.4%) vs 568 credit (22.6%).
2. **Channels are evenly used:** Branch 868 (34.6%), ATM 833 (33.2%), Online 811 (32.3%).
3. **Average amounts are similar:** credit 306.50 vs debit 294.99, a small difference.
4. **Young customers spend the most:** the 18-30 age group has the highest average transaction (319.24), and students have the highest average by occupation.
5. **October is the busiest month** by number of transactions.
6. **Fort Worth (70 transactions) and Los Angeles lead** by location, but no single city dominates.
7. **113 transactions (4.5%) are unusually large** (above 913.49 by the IQR rule). They need review, but are not necessarily fraud.
8. **Most logins are clean:** 95.1% of transactions needed 1 login attempt, and about 4.9% (122) needed 2 to 5 attempts.

## SQL Analysis (PostgreSQL)
The cleaned CSV was loaded into PostgreSQL and analysed with `queries.sql`:
- Channel share (%) using a window function
- Average amount by occupation
- Transactions by day of week
- Top 10 accounts by total amount
- Month-over-month change using a CTE and `LAG`
- Risk groups using `CASE WHEN`


## Recommendations
1. Review the 5 transactions with both a high amount and multiple login attempts first, then the 113 high-value transactions.
2. Monitor accounts with repeated login attempts.
3. Offer targeted products to the 18-30 age group and students.
4. Keep branch, ATM and online services equally strong, since all three are used almost equally.
5. Investigate the sharp drop in April.

## Limitations
- The data appears to be synthetic, so results may not match a real bank.
- There is no fraud label, so "unusual" does not mean "fraud".
- Some differences (credit vs debit average, channel split) are small and may not be meaningful.
- The dataset has only 2,512 transactions.


## Author
Vandana Lodhiyal