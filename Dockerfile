FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy app files
COPY . .

# Install PHP dependencies
 RUN composer install

# Expose port 9000 for PHP-FPM
EXPOSE 9000
 
# Start PHP-FPM
CMD ["php-fpm"]

# Give proper permissions (if needed)
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www
