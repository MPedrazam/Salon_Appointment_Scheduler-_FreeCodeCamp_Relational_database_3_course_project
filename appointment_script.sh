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
