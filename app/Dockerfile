# syntax=docker/dockerfile:1
FROM ruby:3.0.0
#package install
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
RUN apt-get install -y nodejs npm

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
RUN rails webpacker:install

# add script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# setting server
CMD ["rails", "server", "-b", "0.0.0.0"]

#データベース設定
#ENV DATABASE_USERNAME ******
#ENV DATABASE_PASSWORD ******
#ENV DATABASE_HOST db 