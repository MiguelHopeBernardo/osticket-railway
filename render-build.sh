#!/bin/bash

# Install required PHP extensions for osTicket
apt-get update
apt-get install -y \
    php8.1-imap \
    php8.1-gd \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-zip \
    php8.1-curl \
    php8.1-json \
    php8.1-openssl \
    php8.1-pdo \
    php8.1-pdo-mysql \
    php8.1-mysqli \
    php8.1-iconv \
    php8.1-fileinfo \
    php8.1-phar \
    php8.1-tokenizer \
    php8.1-ctype \
    php8.1-session \
    php8.1-filter \
    php8.1-hash \
    php8.1-pcre \
    php8.1-reflection \
    php8.1-xmlreader \
    php8.1-xmlwriter \
    php8.1-zlib

echo "PHP extensions installed successfully" 