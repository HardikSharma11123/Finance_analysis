SELECT c.customer_id, c.first_name, c.last_name
FROM customers as c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT t.customer_id 
    FROM transactions t 
    WHERE t.is_fraud = 1
);


WITH customer_spend AS (
    SELECT 
        c.first_name AS first_name,
        c.last_name AS last_name,
        SUM(t.amount) AS total_spend
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    first_name,
    last_name,
    total_spend,
    RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM customer_spend;


WITH customer_state_spend AS (
    SELECT 
        c.state,
        c.first_name AS first_name,
        c.last_name AS last_name,
        SUM(t.amount) AS total_spend
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.state, c.first_name, c.last_name
)
SELECT 
    state,
    first_name,
    last_name,
    total_spend,
    DENSE_RANK() OVER (PARTITION BY state ORDER BY total_spend DESC) AS state_spend_rank
FROM customer_state_spend
ORDER BY state ASC, state_spend_rank ASC;


SELECT 
    customer_id,
    txn_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id 
        ORDER BY txn_date ASC
    ) AS running_total
FROM transactions
WHERE customer_id = 630441765090
ORDER BY txn_date ASC;


WITH monthly_spend AS (
    SELECT 
        DATE_TRUNC('month', txn_date) AS txn_month,
        SUM(amount) AS current_month_spend
    FROM transactions
    GROUP BY DATE_TRUNC('month', txn_date)
),
with_lag AS (
    SELECT 
        txn_month,
        current_month_spend,
        LAG(current_month_spend) OVER (ORDER BY txn_month) AS previous_month_spend
    FROM monthly_spend
)
SELECT 
    txn_month,
    current_month_spend,
    previous_month_spend,
    ROUND(100.0 * (current_month_spend - previous_month_spend) 
          / NULLIF(previous_month_spend, 0), 2) AS mom_growth_percentage
FROM with_lag
ORDER BY txn_month;