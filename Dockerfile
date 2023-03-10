# FROM ruby:3.0
FROM ruby:2.7.4-alpine3.14

RUN apk add --no-cache git libc6-compat build-base mariadb-dev postgresql-dev postgresql-client tzdata shared-mime-info
RUN gem install bundler --no-document

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
COPY . .
# COPY ./database.yml /app/config/database.yml

ENV PORT=8080

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
