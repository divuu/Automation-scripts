#!/bin/bash

# Prompt the user for input
echo "Enter your choice:"
echo "1. Kafka1"
echo "2. Kafka2"
echo "3. kafka3"
read choice 

# Check the user's choice and execute corresponding commands
case $choice in
    1)
        echo "You selected Kafka1."
        # Run commands fommr Option 1
        sshpass -p '<*Password*>' ssh -o StrictHostKeyChecking=no azureuser@10.10.10.10
        #ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    2)
        echo "You selected Kafka2."
        # Run commands for Option 2
        sshpass -p '<*Password*>' ssh -o StrictHostKeyChecking=no azureuser@10.10.10.10
        #ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    3)
        echo "You selected Kafka3."
        # Run commands for Option 3
        sshpass -p '<*Password*>' ssh -o StrictHostKeyChecking=no azureuser@10.10.10.10
        #ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    *)
        echo "Invalid choice."
        ;;
esac



#!/bin/bash

# Prompt the user for input
echo "Enter your choice:"
echo "1. RabbitMQ1"
echo "2. RabbitMQ2"
echo "3. RabbitMQ3"
read choice 

# Check the user's choice and execute corresponding commands
case $choice in
    1)
        echo "You selected RabbitMQ1."
        # Run commands fommr Option 1
        #sshpass -p '<*Password*>' ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    2)
        echo "You selected RabbitMQ2."
        # Run commands for Option 2
        #sshpass -p '<*Password*> ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    3)
        echo "You selected RabbitMQ3."
        # Run commands for Option 3
        #sshpass -p '<*Password*>' ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ssh -o StrictHostKeyChecking=no azureuser@<private ip>
        ;;
    *)
        echo "Invalid choice."
        ;;
esac


#< Mongo DB = commands >

mongodump --uri="mongodb+srv://<username>:<password>@kc-dev-new.duj.mongodb.net/dev_db" --collection cities --archive=/<folder>/cities.gz --gzip

mongo "mongodb+srv://<username>:<password>@kc-dev-new.duj.mongodb.net/admin?authSource=admin&replicaSet=kc-dev-new" --tls
