FROM ruby:3.2.8

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    postgresql-client \
    build-essential \
    libpq-dev \
    libyaml-dev \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    pkg-config \
    git \
    curl \
    vim \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vscode

WORKDIR /workspace

USER vscode

CMD ["bash"]