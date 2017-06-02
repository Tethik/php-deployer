docker build --build-arg GITHUB_URI="https://github.com/bdart/piibe.git" \
             --build-arg BUILD_ID=$RANDOM \
             -t php-app .