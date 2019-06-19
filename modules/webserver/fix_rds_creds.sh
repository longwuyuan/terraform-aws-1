#!/bin/bash

rds_host=`cat /tmp/rds_endpoint | cut -f1 -d ":"`
rds_password=`cat /tmp/rds_password`

sed -i "s/rds_host/$rds_host/g" /usr/share/nginx/html/index.php
sed -i "s/rds_password/$rds_password/g" /usr/share/nginx/html/index.php

