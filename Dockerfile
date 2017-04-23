FROM ruby:2.4.1

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential git && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

ENV APP /app
RUN mkdir -p $APP
WORKDIR $APP

# throw errors if Gemfile has been modified since Gemfile.lock
RUN gem install bundler && bundle config --global frozen 1 && \
    bundle config git.allow_insecure true && \
    bundle config --delete bin

COPY Gemfile $APP
COPY Gemfile.lock $APP
RUN bundle install --jobs 20 --retry 5

COPY . $APP

CMD puma -C config/puma.rb