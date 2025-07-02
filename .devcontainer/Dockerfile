FROM ruby:3.2.8

# Install system dependencies
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

# Install Yarn
RUN npm install -g yarn

# Create a non-root user
RUN groupadd --gid 1000 vscode \
    && useradd --uid 1000 --gid vscode --shell /bin/bash --create-home vscode \
    && echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vscode

# Set up the working directory
WORKDIR /workspace

# Switch to non-root user
USER vscode

# Default command
CMD ["bash"]