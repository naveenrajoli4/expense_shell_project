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

if [ $USERID -ne 0 ]
then
    echo " you should be a root user to run this script"
    exit 1
else
    echo "ROOT__USER__SUCCESSFULLY__VERFIED!"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql-server -y
    VALIDATE $? "INSTALLING MYSQL"
else
    echo "mysql is already installed"
fi 

systemctl enable mysqld
VALIDATE $? "enabling mysql"

systemctl start mysqld
VALIDATE $? "starting mysql"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "setting mysql password"







