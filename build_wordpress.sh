docker build --build-arg GITHUB_URI="https://github.com/WordPress/WordPress.git" \
             --build-arg BUILD_ID=$RANDOM \
             -t php-app .

