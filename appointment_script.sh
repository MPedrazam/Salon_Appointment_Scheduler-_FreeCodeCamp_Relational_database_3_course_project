echo '#! /bin/bash' > salon.sh #create the file and print the shebang
chmod +x salon.sh #grant executable permissions

-------------------------
#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~"

SERVICE_MENU(){

  if [[ $1 ]] # print the text upfront the function, before returned to the initial part
  then
    echo -e "\n$1"
  else
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  fi

  SERVICES=$($PSQL "SELECT service_id, name FROM services")

  echo $SERVICES | while read SERVICE_ID1 BAR SERVICE1 SERVICE_ID2 BAR SERVICE2 SERVICE_ID3 BAR SERVICE3 SERVICE_ID4 BAR SERVICE4 SERVICE_ID5 BAR SERVICE5
  do
    echo -e "$SERVICE_ID1) $SERVICE1\n$SERVICE_ID2) $SERVICE2\n$SERVICE_ID3) $SERVICE3\n$SERVICE_ID4) $SERVICE4\n$SERVICE_ID5) $SERVICE5"
  done

  read SERVICE_ID_SELECTED

  #SERV=$($PSQL "SELECT service_id FROM services")
  #ARR=($SERV)
  if [[ ! $SERVICE_ID_SELECTED =~ ([1-5]) ]]  
  then
    SERVICE_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      ADD_CUSTOMER_NAME_PHONE=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
      echo -e "\nWhat time would you like your $SERVICE, $CUSTOMER_NAME"
      read SERVICE_TIME
    else
      SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
      echo -e "\nWhat time would you like your"$SERVICE","$CUSTOMER_NAME""
      read SERVICE_TIME
    fi

    CUSTOMER=$($PSQL "SELECT name FROM customers WHERE phone ='$CUSTOMER_PHONE'")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone ='$CUSTOMER_PHONE'")
    INSERT_APP=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES ('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")
  fi
  echo -e "\nI have put you down for a"$SERVICE" at "$SERVICE_TIME,$CUSTOMER"."
  } 

SERVICE_MENU
