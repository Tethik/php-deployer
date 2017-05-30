#!/bin/bash
 
docker run --env-file environment_variables -p 80:80 --dns 205.251.197.132 php-app