#!/bin/bash

docker build $(./buildargs.sh example_build_args_public) --build-arg BUILD_ID=$RANDOM -t php-app .