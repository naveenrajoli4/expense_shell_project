#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/scriptlogs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2..  $R failure $N "
        exit 1
    else
        echo -e "$2... $G SUCCESS $N"
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo -e "$R You should a root user to run this script $N "
    exit 1
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then 
    dnf install mysql-server -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing-mysql"
else
    echo -e "$Y MYSQL is already installed $N"
fi

systemctl enable mysqld &>>$LOG_FILE_NAME
VALIDATE $? "enable-mysqld-service"


systemctl start mysqld &>>$LOG_FILE_NAME
VALIDATE $? "start-mysqld-service"