#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

mkdir -p /var/log/expense_log

LOGS_FOLDER="/var/log/expense_log"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
        echo -e "$2.....$R FAILURE $N"
    else
        echo -e "$2......$G!SUCCESS $N"
    fi
}


 if [ $USERID -ne 0 ]
    then
        echo -e "$R you should be a root user to run this script $N"
        exit 1
    else
        echo -e "$G successfully verified ---ROOT_USER $N"
fi

echo -e "script started at: $TIMESTAMP" &>>$LOG_FILE_NAME



for package in $@
do
    dnf list installed $package &>>$LOG_FILE_NAME
  if [ $1 -ne 0 ]
  then
      dnf install $package -y &>>$LOG_FILE_NAME
      VALIDATE $? "installing $package"
   else
     echo -e "$Y $package is allrady installed $N"
    fi
done

