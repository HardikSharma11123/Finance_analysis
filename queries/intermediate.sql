select category,count(*) as total_transaction_count , sum(amount) as total_amount from transactions group by category order by total_amount desc;


select category, round(avg(amount),2) as total_avg from transactions group by category having AVG(amount) > 100;


select first_name, last_name, trans_id, amount from customers join transactions on customers.customer_id=transactions.customer_id where is_fraud=1;


select merchant_clean, sum(amount) as total_amount from merchants join transactions on merchants.merchant_id=transactions.merchant_id group by merchant_clean order by total_amount desc limit 10;


select first_name, last_name, sum(amount) as amount from customers join transactions on customers.customer_id=transactions.customer_id group by customers.customer_id order by amount desc limit 10;


select * from merchants limit 10;
select * from transactions limit 10;