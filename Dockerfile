FROM php:7.4-apache

# Install basic dependencies for GD
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# Install only extensions that aren't already included
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli

# Configure and install GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Configure Apache for osTicket
RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/osticket.conf
RUN a2enconf osticket

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"] 