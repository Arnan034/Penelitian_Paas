#!/bin/sh
set -e

# Pastikan folder tmp/pids ada & hapus file PID lama
mkdir -p tmp/pids
rm -f tmp/pids/server.pid

echo "Menjalankan migrasi database..."
bundle exec rails db:migrate RAILS_ENV=development

# echo "Menjalankan seeder (jika ada)..."
bundle exec rails db:seed RAILS_ENV=development || echo "Seeder optional, lanjut..."

echo "Menjalankan Puma server..."
bundle exec puma -C config/puma.rb
