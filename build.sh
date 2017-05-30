#!/bin/bash

docker build --build-arg GITHUB_URI="git@github.com:Tethik/healthcheck.git" -t php-app . 