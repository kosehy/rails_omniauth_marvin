FROM ruby:2.6.3-alpine

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata yarn git

RUN mkdir /project
WORKDIR /project

COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3
# CMD ["bundle", "exec", "figaro", "install"]
# CMD ["bundle", "rails", "g", "devise:install"]
# CMD ["bundle", "rails", "g", "devise:views"]
# CMD ["bundle", "rails", "g", "devise", "User"]
# CMD ["bundle", "exec", "run", "rails", "db:migrate"]

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]