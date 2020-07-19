FROM ruby:2.6.3-alpine

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata yarn git

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3

COPY . .

RUN yarn install --check-files
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]