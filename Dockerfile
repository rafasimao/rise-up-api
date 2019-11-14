FROM ruby:2.6.5-alpine

RUN apk update && \
    apk add --no-cache --virtual \
      git \
      bash \
      build-base \
      postgresql-dev

RUN mkdir /app
WORKDIR /app

RUN gem install bundler

CMD ["./docker-entrypoint.sh"]
