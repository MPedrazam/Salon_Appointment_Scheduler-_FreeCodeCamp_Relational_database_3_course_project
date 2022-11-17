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
    service_name VARCHAR
        );

ALTER TABLE services(
    service_name) 
    VALUES ('cut'),
            ('2'),
            ('3'),
            ('4');
        
------------------------------------------------------------
1. You should create a script file named salon.sh in the project folder
2. Your script file should have a “shebang” that uses bash when the file is executed (use #! /bin/bash)
3. Your script file should have executable permissions
4.You should not use the clear command in your script


echo '#! /bin/bash' > touch salon.sh
chmod +x salon.sh


5. You should display a numbered list of the services you offer before the first prompt for input, each with the format #) <service>. For example, 1) cut, where 1 is the service_id
6.If you pick a service that doesn't exist, you should be shown the same list of services again
7.Your script should prompt users to enter a service_id, phone number, a name if they aren’t already a customer, and a time. You should use read to read these inputs into variables named SERVICE_ID_SELECTED, CUSTOMER_PHONE, CUSTOMER_NAME, and SERVICE_TIME
8.If a phone number entered doesn’t exist, you should get the customers name and enter it, and the phone number, into the customers table

#$($PSQL "")

#list of services
SERVICE_MENU(){
    echo -e "\nwhich service would you like to appoint?\n"
    SERVICES=$($PSQL "SELECT service_id, service_name FROM services")
    echo $SERVICES | while read SERVICE_ID BAR SERVICE  
    do
        echo -e "$SERVICE_ID) $SERVICE"
    done
    
    $SERVICE_ID=$($PSQL "SELECT service_id FROM services")
    read SERVICE_ID_SELECTED
    if [[ $SERVICE_ID_SELECTED != $SERVICE_ID ]]
    then
        SERVICE_MENU "Please select one of the available choices"
    else
    echo -e "\nPlease enter your phone number\n"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER'")
        if [[ -z CUSTOMER_NAME ]]
        then
            echo "\nWhat is your name?"
            read CUSTOMER_NAME
            ADDED_CUSTOMER_NAME_PHONE=$($PSQL "ALTER TABLE customers(name, phone) VALUES ('$CUSTORMER_NAME', $PHONE)")
        else
            echo "What time would you like to schedule the appointment?"
            read SERVICE_TIME
            
            if [[ ! $SERVICE TIME =~ ^[6-18]+$]]
            then 
                SERVICE_MENU "\nPlease enter an hour amont 6 to 18"
            else
                SCHE_TIME=$($PSQL "ALTER TABLE appointments(time) VALUES ($SERVICE_TIME)")
            fi
        SERVICE=$($PSQL "SELECT service FROM services WHERE service_id=$SERVICE_ID_SELECTED")
        echo -e "\nI have put you down for a $SERVICE at $SCHE_TIME, $CUSTOMER_NAME"
        fi
    fi
}

9. You can create a row in the appointments table by running your script and entering 1, 555-555-5555, Fabio, 10:30 at each request for input if that phone number isn’t in the customers table. The row should have the customer_id for that customer, and the service_id for the service entered

11. You can create another row in the appointments table by running your script and entering 2, 555-555-5555, 11am at each request for input if that phone number is already in the customers table. The row should have the customer_id for that customer, and the service_id for the service entered

12. After an appointment is successfully added, you should output the message I have put you down for a <service> at <time>, <name>. For example, if the user chooses cut as the service, 10:30 is entered for the time, and their name is Fabio in the database the output would be I have put you down for a cut at 10:30, Fabio. Make sure your script finishes running after completing any of the tasks above, or else the tests won't pass
