#!/bin/bash
cd /var/git 
service nginx start
php-fpm &
trap "kill -SIGQUIT $!" INT
wait