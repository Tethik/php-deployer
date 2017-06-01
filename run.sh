#!/bin/bash
 
docker run --env HELLO_WORLD_MSG="from Joakim" -p 80:80 --dns 205.251.197.132 php-app