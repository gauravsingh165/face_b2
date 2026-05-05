FROM ruby:3.2.0

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV RAILS_ENV=production

RUN RAILS_ENV=production bundle exec rake assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]