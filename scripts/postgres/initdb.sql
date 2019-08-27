CREATE DATABASE kappademo;
\connect kappademo;

-- -- Gets called on docker-compose up - use 1 database for all tables for the moment
-- create table TRANSACTION (
--         id SERIAL PRIMARY KEY,
--
--         merchant_id BIGINT,
--         payment_scheme VARCHAR(50),
--
--         transaction_type VARCHAR(50),
--         transaction_amount BIGINT,
--
-- --      terminal_business_day timestamp DEFAULT CURRENT_TIMESTAMP
--         terminal_business_day VARCHAR(50)
-- );
--
-- create table SUMMARY (
--         MERCHANT_ID BIGINT,
--         PAYMENT_SCHEME VARCHAR(50),
--         PURCHASES_TOTAL BIGINT,
-- --      terminal_business_day date DEFAULT CURRENT_DATE
--         PRIMARY KEY (MERCHANT_ID, PAYMENT_SCHEME)
-- );
