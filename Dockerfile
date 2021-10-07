FROM ruby:2.7.0

WORKDIR /app
ADD Gemfile* /app/
ADD . /app
COPY config/database.example.yml config/database.yml
ARG RAILS_ENV

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client \
  && bundle install

EXPOSE 3000

CMD bundle exec rails s
