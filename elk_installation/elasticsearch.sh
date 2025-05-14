#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi

sudo yum install java-11-openjdk-devel -y &>>$LOGFILE
VALIDATE $? "Java 11 Installation"

sudo cp /home/ec2-user/11.4.create_ELK_server/elk_installation/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo &>>$LOGFILE
VALIDATE $? "created elasticsearch.repo"

sudo yum install elasticsearch -y &>>$LOGFILE
VALIDATE $? "elasticsearch Installation"

sudo sed -i 's/#http.port: 9200/http.port: 9200/' /etc/elasticsearch/elasticsearch.yml &>> $LOGFILE
VALIDATE $? "replaced http.port: 9200"

sudo sed -i 's/#network.host: 192.168.0.1/network.host: 0.0.0.0/' /etc/elasticsearch/elasticsearch.yml &>> $LOGFILE
VALIDATE $? "replaced network.host: 0.0.0.0"

sudo sed -i '/^#discovery/ a discovery.type: single-node' /etc/elasticsearch/elasticsearch.yml &>> $LOGFILE
VALIDATE $? "adding discovery.type: single-node"


sudo systemctl restart elasticsearch &>>$LOGFILE
VALIDATE $? "elasticsearch restarting service"

sudo systemctl enable elasticsearch &>>$LOGFILE
VALIDATE $? "elasticsearch enable service"