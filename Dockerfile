FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn \
  && mkdir /let2-test

WORKDIR /let2-test
COPY /Gemfile /let2-test/Gemfile
COPY /Gemfile.lock /let2-test/Gemfile.lock
RUN bundle install
COPY . /let2-test

EXPOSE 3000
