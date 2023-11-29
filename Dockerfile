# Use an official PHP image with Apache for PHP 8.2.12
FROM php:8.2.12-apache

# Install required PHP extensions and other dependencies
RUN docker-php-ext-install pdo pdo_mysql

# Install ICU libraries and headers
RUN apt-get update && apt-get install -y libicu-dev

# Configure and install the intl extension
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN apt-get install -y nano git

# Enable mod_rewrite
RUN a2enmod rewrite

# Set Apache's DocumentRoot to the webroot directory
#RUN sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

COPY apache2.conf /etc/apache2/apache2.conf

# Copy the Apache security headers configuration file
COPY security-headers.conf /etc/apache2/conf-available/security-headers.conf

# Enable the security headers configuration
RUN ln -s /etc/apache2/conf-available/security-headers.conf /etc/apache2/conf-enabled/

# Enable the headers module
RUN a2enmod headers

# Set the working directory
WORKDIR /var/www/html

# Copy your CakePHP application files into the container
COPY . /var/www/html

# Copy .htaccess files
COPY .htaccess /var/www/html/.htaccess
COPY webroot/.htaccess /var/www/html/webroot/.htaccess

# Expose the port that Apache will listen on
EXPOSE 80
EXPOSE 443

# Restart Apache to apply the changes
RUN service apache2 restart

# Start Apache in the foreground
CMD ["apache2-foreground"]
