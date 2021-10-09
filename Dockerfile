FROM ruby:2.7.0

WORKDIR /comarev
COPY Gemfile /comarev/Gemfile
COPY Gemfile.lock /comarev/Gemfile.lock
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler:2.2.15
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD bundle exec rails s
