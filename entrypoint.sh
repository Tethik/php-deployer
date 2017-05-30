#!/bin/bash
service nginx start
php-fpm &
trap "kill -SIGQUIT $!" INT
wait