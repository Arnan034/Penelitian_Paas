#!/bin/sh
set -e

# Jalankan migrasi
bundle exec rails db:migrate RAILS_ENV=development

# Jalankan Puma
bundle exec puma -C config/puma.rb
