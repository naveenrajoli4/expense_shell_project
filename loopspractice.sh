#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir /var/log/expense_log

LOGS_FOLDER="/var/log/expense_log"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE() {
    if ($1 -ne 0)
    then 
        echo "$2.....$R FAILURE $N"
    else
        echo "$2......$G!SUCCESS $N"
    fi
}

CHECK_ROOT() {
    if ($USERID -ne 0)
    then
        echo "$R you should be a root user to run this script $N"
        exit 1
    else
        echo "$G successfully verified ---ROOT_USER $N"
    fi
}

echo " script started at: $TIMESTAMP" &>>$LOG_FILE_NAME

for package in $@
do
  if ($1 -ne 0)
  then
      dnf install $package -y &>>$LOG_FILE_NAME
      $VALIDATE $? "installing $package"
   else
     echo "$Y $package is allrady installed $N"
done

