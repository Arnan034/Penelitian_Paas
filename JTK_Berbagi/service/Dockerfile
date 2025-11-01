# syntax=docker/dockerfile:1
FROM ruby:3.1.7

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y curl gnupg2 default-mysql-client && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

# Ruby deps
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Node deps
COPY package.json yarn.lock ./
RUN yarn install

# App source
COPY . .

# Normalize line endings (CRLF -> LF) and ensure executables
RUN sed -i 's/\r$//' entrypoint.sh || true && \
    chmod +x entrypoint.sh && \
    find db/migrate -type f -name "*.rb" -exec sed -i 's/\r$//' {} + || true && \
    find bin -type f -exec sed -i 's/\r$//' {} + || true

EXPOSE 8000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
