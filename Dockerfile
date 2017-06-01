FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    nginx

# Copy nginx site settings
ADD files/nginx/default.conf /etc/nginx/sites-enabled/default

# Remove nginx default site that came install with apt-get
RUN rm -r /var/www/html/*

RUN mkdir /var/git

# Add the ssh private/public keys if supplied
ARG SSH_CREDENTIALS=files/.empty_folder/*
ADD $SSH_CREDENTIALS /root/.ssh/

ARG GITHUB_URI
RUN [ "$GITHUB_URI" != "" ]
# If build ID changes the cache for the following commands is invalidated and the repo will be freshly cloned.
ARG BUILD_ID
RUN echo $BUILD_ID

RUN git clone $GITHUB_URI /var/git

# Checkout/export to avoid .git folder from being published
RUN cd /var/git && git --work-tree=/var/www/html checkout -f -q

ENTRYPOINT ["entrypoint.sh"]
COPY files/scripts/entrypoint.sh /usr/local/bin/

EXPOSE 80