FROM php:8.2-fpm

LABEL maintainer="MtronikaSP <support@mtronika.co.za>"

RUN apt-get update && apt-get install -y \
mariadb-client \
git \
unzip \
libpq-dev \
libpng-dev \
libjpeg62-turbo-dev \
libfreetype6-dev \
zip \
libzip-dev \
libmcrypt-dev \
&& docker-php-ext-install pdo_mysql zip gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer --version

WORKDIR /var/www

# Copy Laravel app
COPY . .

# Set proper permissions
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]