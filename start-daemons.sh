#!/bin/bash

sudo systemctl start mongod
echo "started MongoDB..."

sudo systemctl start mariadb
echo "started MariaDB..."

sudo systemctl start php-fpm
echo "started PHP-Fpm..."

sudo systemctl start nginx
echo "started Nginx..."

sudo systemctl start postgresql
echo "started Postgresql..."
