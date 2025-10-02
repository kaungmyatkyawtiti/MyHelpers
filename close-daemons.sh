#!/bin/bash

sudo systemctl stop mongod
echo "stopped MongoDB..."

sudo systemctl stop mariadb
echo "stopped MariaDB..."

sudo systemctl stop php-fpm
echo "stopped PHP-Fpm..."

sudo systemctl stop nginx
echo "stopping Nginx..."
