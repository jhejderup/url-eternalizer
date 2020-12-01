FROM ruby:2.3

# add external dependencies
RUN apt-get update -qq && apt-get install -y libldap2-dev libidn11-dev

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["ruby", "src/cli.rb"]