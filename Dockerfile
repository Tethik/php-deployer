FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    nginx

# Copy nginx site settings
ADD files/nginx/default.conf /etc/nginx/sites-enabled/default

# Remove nginx default site that came install with apt-get
RUN rm -r /var/www/html/*

RUN mkdir /var/git /var/export

# Add the ssh private/public keys if supplied, otherwise just an empty directory
ARG SSH_CREDENTIALS=files/.empty_folder/*
ADD $SSH_CREDENTIALS /root/.ssh/

# Enforces that github uri is set.
ARG GITHUB_URI
RUN [ "$GITHUB_URI" != "" ]

# If build ID changes the cache for the following commands is invalidated and the repo will be freshly cloned.
ARG BUILD_ID
RUN echo $BUILD_ID

RUN git clone $GITHUB_URI /var/git

COPY files/scripts/ /usr/local/bin/

# Checkout/export to avoid .git folder from being published
RUN cd /var/git && git --work-tree=/var/export checkout -f -q

ARG GIT_SUBDIRECTORY
RUN mv -T /var/export/$GIT_SUBDIRECTORY /var/www/html

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80