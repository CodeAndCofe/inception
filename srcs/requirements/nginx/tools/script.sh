#!/bin/bash

FILE=$(cat "ngx.cnf")

echo $FILE > "nginx.conf"