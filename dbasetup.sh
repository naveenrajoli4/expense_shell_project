#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p "/var/log/expense_log"

LOGS_FOLDER="/var/log/expense_log"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 .....FAILURE"
        exit 1
    else
        echo -e "$2-------SUCCESS"
    fi
}

echo "script started at: $TIMESTAMP"

$USERID 
VALIDATE $? "rootuser"

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then 
    dnf install mysql-server -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing-mysql"
else
    echo -e "$Y MYSQL is already installed $N"
fi




