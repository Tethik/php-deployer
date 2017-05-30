FROM php:7.1-fpm
ARG GITHUB_URI

RUN apt-get update && apt-get install -y \
    git \
    nginx

# Copy nginx site settings
ADD nginx/default.conf /etc/nginx/sites-enabled/default

# Remove nginx default site that came install with apt-get
RUN rm -r /var/www/html/*

# Add the ssh private/public keys (don't worry these are completely new and only has read access to the php repo)
ADD credentials/* /root/.ssh/

RUN git clone $GITHUB_URI /var/www/html

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80