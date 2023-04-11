-- SQL-команды для создания таблиц

CREATE TABLE employees
(
    first_name varchar(20),
    last_name  varchar(20),
    title      varchar(50),
    birth_date date,
    notes      text
);

CREATE TABLE customers
(
    customer_id  varchar(20),
    company_name varchar(50),
    contact_name varchar(50)
);

CREATE TABLE orders
(
    order_id    int,
    customer_id varchar(20),
    employee_id int,
    order_date  date,
    ship_city   varchar(50)
);