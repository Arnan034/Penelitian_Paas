#!/bin/sh
set -e

# 1️⃣ Tampilkan environment variables
echo "===== Environment Variables ====="
echo "APP_ENV: $APP_ENV"
echo "APP_DEBUG: $APP_DEBUG"
echo "APP_KEY: $APP_KEY"
echo "DB_CONNECTION: $DB_CONNECTION"
echo "DB_HOST: $DB_HOST"
echo "DB_PORT: $DB_PORT"
echo "DB_DATABASE: $DB_DATABASE"
echo "DB_USERNAME: $DB_USERNAME"
echo "DB_PASSWORD: $DB_PASSWORD"
echo "================================="

# 2️⃣ Buat .env jika belum ada
if [ ! -f ".env" ]; then
    echo "Creating .env file..."
    if [ -f ".env.example" ]; then
        cp .env.example .env
    else
        cat > .env <<EOL
APP_NAME=Laravel
APP_ENV=$APP_ENV
APP_KEY=$APP_KEY
APP_DEBUG=$APP_DEBUG
APP_URL=http://localhost

DB_CONNECTION=$DB_CONNECTION
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_DATABASE=$DB_DATABASE
DB_USERNAME=$DB_USERNAME
DB_PASSWORD=$DB_PASSWORD
EOL
    fi
fi

# 3️⃣ Generate APP_KEY jika belum ada
if ! grep -q "APP_KEY=" .env || [ -z "$(grep 'APP_KEY=' .env | cut -d '=' -f2)" ]; then
    echo "Generating Laravel APP_KEY..."
    php artisan key:generate
fi

# 4️⃣ Tunggu database siap
echo "Waiting for database to be ready..."
until mysql -h"$DB_HOST" -u"$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1;" &> /dev/null
do
    echo "Database not ready yet..."
    sleep 2
done
echo "Database is ready!"

# 5️⃣ Jalankan migration otomatis
echo "Running database migrations..."
php artisan migrate --force

# 6️⃣ Jalankan seeder jika ada
echo "Running database seeders..."
php artisan db:seed --force || echo "No seeders found."

# 7️⃣ Jalankan Laravel server
echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=80
