CREATE DATABASE kappademo;
\connect kappademo;

-- Gets called on docker-compose up - use 1 database for all tables for the moment
create table TRANSACTION (
        id SERIAL PRIMARY KEY,

        merchant_id BIGINT,
        location_id VARCHAR(50),
        terminal_id BIGINT,
        payment_scheme VARCHAR(50),

        transaction_type VARCHAR(50),
        transaction_amount BIGINT,

--         terminal_business_day timestamp DEFAULT CURRENT_TIMESTAMP
        terminal_business_day VARCHAR(50)
);

create table LOCATION_SUMMARY (
        merchant_id BIGINT,
        location_id VARCHAR(50),
        terminal_id BIGINT,
        payment_scheme VARCHAR(50),

        signed_amount BIGINT,
        absolute_amount BIGINT,
        terminal_business_day date DEFAULT CURRENT_DATE
);
