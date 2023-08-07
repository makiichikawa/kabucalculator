FROM ruby:3.0.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /appserver
WORKDIR /appserver
COPY ../appserver/Gemfile /appserver/Gemfile
COPY ../appserver/Gemfile.lock /appserver//Gemfile.lock
RUN echo ":ipv4_fallback_enabled: true" >> ~/.gemrc
RUN gem install bundler
RUN bundle install
COPY ../appserver/package.json /appserver/package.json
COPY ../appserver/yarn.lock /appserver/yarn.lock
RUN yarn install
COPY ../appserver /appserver
