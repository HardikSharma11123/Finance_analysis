CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    dob DATE,
    job VARCHAR(150),
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip VARCHAR(20),
    lat NUMERIC(9, 6),
    long NUMERIC(9, 6),
    city_pop INT
);

CREATE TABLE merchants (
    merchant_id INT PRIMARY KEY,
    merchant_clean VARCHAR(255) NOT NULL,
    merch_lat NUMERIC(9, 6),
    merch_long NUMERIC(9, 6),
    merch_zipcode VARCHAR(20)
);

CREATE TABLE transactions (
    trans_id VARCHAR(50) PRIMARY KEY,
    customer_id BIGINT NOT NULL REFERENCES customers(customer_id),
    merchant_id INT NOT NULL REFERENCES merchants(merchant_id),
    txn_date TIMESTAMP NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    category VARCHAR(100),
    is_fraud SMALLINT
);