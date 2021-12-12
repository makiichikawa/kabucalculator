FROM ruby:3.0.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /appserver
WORKDIR /appserver
COPY ./appserver/Gemfile /appserver/Gemfile
COPY ./appserver/Gemfile.lock /appserver//Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY ./appserver /appserver