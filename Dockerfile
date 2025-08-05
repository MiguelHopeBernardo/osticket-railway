FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libgd-dev \
    libimap-dev \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    mbstring \
    xml \
    zip \
    curl \
    json \
    openssl \
    pdo \
    pdo_mysql \
    mysqli \
    iconv \
    fileinfo \
    phar \
    tokenizer \
    ctype \
    session \
    filter \
    hash \
    pcre \
    reflection \
    xmlreader \
    xmlwriter \
    zlib \
    imap

# Enable Apache modules
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy osTicket files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configure Apache
RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/osticket.conf \
    && a2enconf osticket

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"] 