# Card Spend & Fraud Analytics (SQL Project)

Simulated card-transaction dataset (source: Kaggle), normalized from a single
1.29M-row flat file into a 3-table relational schema, sampled to 200 customers
(255,648 transactions) for query performance.

## Schema decisions
- 3 tables (customers, merchants, transactions) instead of the typical 4 — 
  cc_num already uniquely identifies one customer, so a separate accounts 
  table was unnecessary.
- Amounts are stored as all-positive spend values (no credit side exists in 
  the source data) — reframed as spend/fraud analytics rather than a 
  full ledger.
- Sampled to 200 customers (full 18-month history each) rather than the full 
  1.29M rows, to keep query iteration fast during development.

## Query ladder
- 10_beginner.sql — filtering, sorting, DISTINCT
- 20_intermediate.sql — GROUP BY, HAVING, joins
- 30_advanced.sql — anti-joins, RANK/DENSE_RANK, running totals, MoM growth (LAG)
- views/vw_monthly_category_summary.sql

## Key Findings

1. **Groceries lead all spend categories.** `grocery_pos` accounts for 
   $2,625,601.44 in total spend across the sample — the single largest 
   category, reflecting the recurring, high-frequency nature of grocery 
   purchases versus one-off categories like travel or entertainment.

2. **Kilback LLC is the top-grossing merchant**, with $75,421.99 in total 
   customer spend — notable concentration given there are 693 merchants 
   in the sample.

3. **Fraud is rare but present.** 0.62% of all transactions are flagged as 
   fraudulent — consistent with real-world card fraud rates, which typically 
   sit well under 1%, making fraud detection a needle-in-a-haystack problem 
   rather than a bulk-filtering one.

4. **Spend is concentrated at the top.** The highest lifetime spender in the 
   sample, Lauren Torres, accounts for $290,478.49 — dramatically above the 
   typical customer, showing the long-tail distribution common in consumer 
   transaction data.

5. **Spend dipped 3.34% from January to February 2019** ($716,742.44 → 
   $692,835.77), illustrating the kind of month-over-month volatility a 
   LAG-based query surfaces instantly — exactly the pattern used to flag 
   revenue or spend anomalies in a monitoring dashboard.
