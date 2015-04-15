FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /legislando
ADD . /legislando
WORKDIR /legislando
RUN bundle install
