CREATE TABLE bank_transactions (
    transaction_id TEXT,
    account_id TEXT,
    transaction_amount NUMERIC,
    transaction_date TIMESTAMP,
    transaction_type TEXT,
    location TEXT,
    device_id TEXT,
    ip_address TEXT,
    merchant_id TEXT,
    channel TEXT,
    customer_age INT,
    customer_occupation TEXT,
    transaction_duration INT,
    login_attempts INT,
    account_balance NUMERIC,
    previous_transaction_date TIMESTAMP,
    month INT,
    day_of_week TEXT,
    age_group TEXT
);

SELECT COUNT(*) FROM bank_transactions;


-- Q1: Har channel ka share (%)
SELECT channel,
       COUNT(*) AS total,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM bank_transactions
GROUP BY channel
ORDER BY total DESC;

-- Q2: Occupation ke hisaab se average amount
SELECT customer_occupation,
       COUNT(*) AS total,
       ROUND(AVG(transaction_amount), 2) AS avg_amount
FROM bank_transactions
GROUP BY customer_occupation
ORDER BY avg_amount DESC;

-- Q3: Din (weekday) ke hisaab se transactions
SELECT day_of_week,
       COUNT(*) AS total,
       ROUND(AVG(transaction_amount), 2) AS avg_amount
FROM bank_transactions
GROUP BY day_of_week
ORDER BY total DESC;

-- Q4: Top 10 accounts (total amount ke hisaab se)
SELECT account_id,
       COUNT(*) AS txn_count,
       ROUND(SUM(transaction_amount), 2) AS total_amount
FROM bank_transactions
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;

-- Q5: Mahine ka total amount aur pichhle mahine se fark
WITH monthly AS (
    SELECT month,
           SUM(transaction_amount) AS total_amount
    FROM bank_transactions
    GROUP BY month
)
SELECT month,
       ROUND(total_amount, 2) AS total_amount,
       ROUND(total_amount - LAG(total_amount) OVER (ORDER BY month), 2) AS change_vs_prev
FROM monthly
ORDER BY month;

-- Q6: Risk groups (bada amount aur zyada login attempts)
SELECT CASE
           WHEN transaction_amount > 913.49 AND login_attempts > 1 THEN 'High amount + multiple logins'
           WHEN transaction_amount > 913.49 THEN 'High amount only'
           WHEN login_attempts > 1 THEN 'Multiple logins only'
           ELSE 'Normal'
       END AS risk_group,
       COUNT(*) AS total
FROM bank_transactions
GROUP BY risk_group
ORDER BY total DESC;