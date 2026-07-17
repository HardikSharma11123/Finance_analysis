CREATE VIEW monthly_category_summary AS
SELECT 
    DATE_TRUNC('month', txn_date) AS txn_month,
    category,
    COUNT(*) AS total_transaction_count,
    SUM(amount) AS total_spend
FROM transactions
GROUP BY DATE_TRUNC('month', txn_date), category;

CREATE INDEX idx_transactions_customer_date 
ON transactions(customer_id, txn_date);

EXPLAIN ANALYZE
SELECT customer_id, txn_date, amount,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY txn_date) AS running_total
FROM transactions
WHERE customer_id = 630441765090
ORDER BY txn_date;