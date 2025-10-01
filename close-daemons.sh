#!/bin/bash

echo "stopping mongoDB..."
sudo systemctl stop mongod

echo "stopping mariaDB..."
sudo systemctl stop mariadb

echo "stopping PHP-fpm..."
sudo systemctl stop php-fpm

echo "stopping nginx..."
sudo systemctl stop nginx

echo "All daemons have been stopped."
