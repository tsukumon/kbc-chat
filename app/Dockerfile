#Installing ruby enviroment
FROM ruby:3.0.0
# yarnインストール時のバージョンを指定
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# パッケージリスト更新後、railsとDBに必要なパッケージインストール
RUN apt-get update && apt-get install -y nodejs postgresql-client yarn

# /appを作業ディレクトリとし、Gemfile Gemfile.lockをコピーする
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# コピーしたGemfile Gemfile.lockに書いてあるGemをinstallする
RUN bundle install

# railsのアプリを含め、すべてのファイルをコピー
COPY . /myapp

# exec when every container started
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

#exec when start container
CMD ["rails", "server", "-b", "0.0.0.0"]
