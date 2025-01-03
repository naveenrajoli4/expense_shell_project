#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $USERID -ne 0 ]
then
    echo -e "$R You should a root user to run this script $N "
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    dnf install mysql-server -y
    if [ $? -ne 0 ]
    then
        echo -e "$R Inatalling mysql...failure $N "
        exit 1
    else
        echo -e " $G Installing mysql...SUCCESS $N"
    fi
else
    echo -e "$Y MYSQL is already installed $N"
fi

systemctl enable mysqld
if [ $? -ne 0 ]
then 
    echo -e "$R mysql enable...failure $N "
    exit 1
else
    echo -e " $G mysql enable....SUCCESS $N"
fi


systemctl start mysqld
if [ $? -ne 0 ]
then 
    echo -e "$R mysql start...failure $N "
    exit 1
else
    echo -e " $G mysql start....SUCCESS $N"
fi