FROM ruby:2.3.1-slim
RUN apt-get update -qq && apt-get install build-essential libpq-dev postgresql-client
ENV RAILS_ROOT /var/www/quest_api
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . .
CMD config/containers/startup.sh
