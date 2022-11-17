CREATE DATABASE salon;
\c salon

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    phone VARCHAR UNIQUE,
    name VARCHAR
        );
        
CREATE TABLE appointments(
    appointment_id SERIAL PRIMARY KEY,
    time VARCHAR,
    customer_id INT, FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    service_id INT, FOREIGN KEY (service_id) REFERENCES services(service_id)
        );
        
CREATE TABLE services(
    service_id SERIAL PRIMARY KEY,
    name VARCHAR
        );

INSERT INTO services(
    service_name) 
    VALUES ('cut'),
            ('color'),
            ('perm'),
            ('style'),
            ('trim');
        
