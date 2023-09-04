
FROM php:8.1 as php

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www
COPY . .

COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer


# Set environment variables for Laravel (customize as needed)
ENV APP_ENV=local
ENV APP_KEY=base64:1YAY9kBb3pue4q57RiKI3TPT0BX8a2fho3j1+HCWcsw=

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP Composer dependencies
RUN composer install --no-dev

ENV PORT=8000
ENTRYPOINT [ "Docker/entrypoint.sh" ]





