#!/bin/bash

docker build --build-arg GITHUB_URI="git@github.com:Tethik/healthcheck.git" \
             --build-arg SSH_CREDENTIALS=credentials/* \
             --build-arg BUILD_ID=$RANDOM \
             --build-arg GIT_SUBDIRECTORY=web/ \
             -t php-app .
