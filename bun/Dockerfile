ARG VARIANT=latest
FROM oven/bun:${VARIANT}

# Install system dependencies as root
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    git \
    curl \
    cloc \
    jq \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && chsh -s $(which bash) bun

# Node.js 22
# We need this for Claude Code. Up to v1.0.65 it worked with Bun, after that it failed
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

    # Cache busting argument - change this value to force rebuild
ARG CACHE_BUST=1

# Claude code
RUN npm install -g @anthropic-ai/claude-code

# Create docker group with host GID and create user
RUN groupadd -g 1001 docker && \
    mkdir -p /home/bun/.local && \
    usermod -aG docker bun && \
    chown -R bun:bun /home/bun

# Switch to bun user
USER bun

# Set up bash prompt and aliases
RUN echo 'export PS1="\e[01;32m\u\e[m:\e[01;34m\w\e[m\$ "' >> /home/bun/.bashrc \
    && echo 'alias c="claude"' >> /home/bun/.bashrc \
    && echo 'alias cc="claude --dangerously-skip-permissions"' >> /home/bun/.bashrc

ENV DEVCONTAINER=true
WORKDIR /workspace
