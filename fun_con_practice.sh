#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo -e "$2..  $R failure $N "
        exit 1
    else
        echo -e "$2... $G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "$R You should a root user to run this script $N "
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    dnf install mysql-server -y
    VALIDATE $? "installing-mysql"
else
    echo -e "$Y MYSQL is already installed $N"
fi

systemctl enable mysqld
VALIDATE $? "enable-mysqld-service"


systemctl start mysqld
VALIDATE $? "start-mysqld-service"