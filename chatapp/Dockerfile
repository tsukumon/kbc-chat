<<<<<<< HEAD
# syntax=docker/dockerfile:1
FROM ruby:3.0.3
# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
=======
FROM ruby:3.0.3
>>>>>>> f35f91f157aa8de26a429e53a44f36b2506151d1

## nodejsとyarnはwebpackをインストールする際に必要
# yarnパッケージ管理ツールをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs build-essential libpq-dev postgresql-client yarn
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

RUN yarn install --check-files
RUN bundle exec rails webpacker:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

#データベース設定
ENV DATABASE_USERNAME tsukumon
ENV DATABASE_PASSWORD password
ENV DATABASE_HOST db 