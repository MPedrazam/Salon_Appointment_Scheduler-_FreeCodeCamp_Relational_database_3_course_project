1. You should create a database named salon
CREATE DATABASE salon;

2. You should connect to your database, then create tables named customers, appointments, and services
3. Each primary key column should follow the naming convention, table_name_id. For example, the customers table should have a customer_id key. Note that there’s no s at the end of customer
4. Your appointments table should have a customer_id foreign key that references the customer_id column from the customers table.
5. Your appointments table should have a service_id foreign key that references the service_id column from the services table
6. Your customers table should have phone that is a VARCHAR and must be unique
7. Your customers and services tables should have a name column
8. Your appointments table should have a time column that is a VARCHAR
9.You should have at least three rows in your services table for the different services you offer, one with a service_id of 1. #At least three producr in the service_name
\c salon

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    phone VARCHAR UNIQUE,
    name VARCHAR,
        );
        
CREATE TABLE appointments(
    appointment_id SERIAL PRIMARY KEY,
    time VARCHAR,
    CONSTRAINT FK_appointments_customers FOREIGN KEY (customer_id) REFECRENCES customers(customer_id),
    CONSTRAINT FK_appointments_services FOREIGN GEY (service_id) REFERENCES services(service_id)
        );
        
CREATE TABLE services(
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR,
        );
