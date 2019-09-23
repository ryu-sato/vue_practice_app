ARG RUBY_VERSION=2.5.3
ARG BUNDLER_BASE_IMAGE=circleci/ruby:${RUBY_VERSION}-node-browsers
ARG APP_BASE_IMAGE=circleci/ruby:${RUBY_VERSION}-node


# アプリケーションが依存するパッケージをインストールしてキャッシュするためのコンテナ
FROM ${BUNDLER_BASE_IMAGE} as bundler
RUN mkdir -p /home/circleci/app
WORKDIR /home/circleci/app

# install bundle gems to /usr/local/bundle
COPY --chown=circleci:circleci Gemfile* ./
RUN bundle install --with production

# install npm packages
COPY --chown=circleci:circleci package.json yarn.lock ./
RUN yarn install


# アプリケーションコンテナ
FROM ${APP_BASE_IMAGE}
WORKDIR /home/circleci/app
EXPOSE 3000

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES 1

COPY --from=bundler --chown=circleci:circleci /usr/local/bundle /usr/local/bundle
COPY --from=bundler --chown=circleci:circleci /home/circleci/app/node_modules /home/circleci/app/node_modules
COPY --chown=circleci:circleci . /home/circleci/app

CMD export SECRET_KEY_BASE=$(rails secret); rails webpacker:compile assets:precompile && rails server -b 0.0.0.0
