FROM ruby:2.6.6-alpine

RUN apk update && \
    apk add --no-cache --virtual \
      git bash less \
      build-base \
      postgresql-client \
      postgresql-dev

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile.lock /app/

RUN bundle install --jobs $(nproc)

ADD . /app

ENTRYPOINT ["./docker-entrypoint.sh"]
