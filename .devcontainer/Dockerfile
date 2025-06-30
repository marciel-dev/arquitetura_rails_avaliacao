FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  npm \
  redis-tools \
  git \
  libvips

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

WORKDIR /workspace

COPY Gemfile Gemfile.lock ./
RUN bundle config set --local path 'vendor/bundle' \
  && bundle install

COPY . .

RUN yarn install --check-files || true

USER $USERNAME
