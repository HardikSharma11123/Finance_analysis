select trans_id,txn_date,amount,category from transactions where amount>500 order by amount desc limit 20;


select distinct category from transactions;


select trans_id,customer_id,amount,category from transactions where is_fraud = 1;


Select first_name, last_name, city, state from customers WHERE state = 'NY';


select trans_id,customer_id,amount,category,txn_date from transactions order by txn_date desc limit 10;


select trans_id,customer_id,amount from transactions where category  in('grocery_pos','gas_transport');