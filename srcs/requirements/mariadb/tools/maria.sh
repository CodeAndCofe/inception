#!/bin/bash

#after installation complete should start maria db  service
service mariadb start
mariadb -h 166.78.144.191 -u username -ppassword database_name
# mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"ls