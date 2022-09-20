# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cron vim

WORKDIR /backend

COPY Gemfile /backend/Gemfile
COPY Gemfile.lock /backend/Gemfile.lock
COPY . .
RUN bundle install

RUN rm -f config/credentials.yml.enc

COPY docker-setup/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["entrypoint.sh"]

CMD bin/rails s -e development -b '0.0.0.0' -p 8000
