FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    gnupg2 \
    ca-certificates \
    unzip \
    software-properties-common \
    cloc \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Cache busting argument - change this value to force rebuild
ARG CACHE_BUST=7

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Install Codex CLI
RUN npm install -g @openai/codex

# Create docker group with host GID and create user
RUN groupadd -g 1001 docker && \
    useradd -m devuser && \
    mkdir -p /home/devuser/.local && \
    usermod -aG docker devuser && \
    chown -R devuser:devuser /home/devuser && \
    chsh -s $(which bash) devuser

USER devuser

# Set up bash prompt and aliases
RUN echo 'export PS1="\e[01;32m\u\e[m:\e[01;34m\w\e[m\$ "' >> /home/devuser/.bashrc \
    && echo 'alias cc="claude --dangerously-skip-permissions"' >> /home/devuser/.bashrc \
    && echo 'alias c="claude"' >> /home/devuser/.bashrc \
    && echo 'alias cx="codex --search"' >> /home/devuser/.bashrc

ENV DEVCONTAINER=true
WORKDIR /home/devuser

EXPOSE 8080
