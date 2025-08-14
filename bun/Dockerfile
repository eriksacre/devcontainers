ARG VARIANT=latest
FROM oven/bun:${VARIANT}

# Install system dependencies as root
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    git \
    curl \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && chsh -s $(which bash) bun

# Set up Bun's global installation environment
ENV BUN_INSTALL="/home/bun/.bun"
ENV PATH="/home/bun/.bun/bin:${PATH}"

# Cache busting argument - change this value to force rebuild
ARG CACHE_BUST=1

# Claude code
RUN bun install -g @anthropic-ai/claude-code

# Change ownership of Bun's installation directory
RUN chown -R bun:bun /home/bun/.bun

# Switch to bun user
USER bun

# Set up bash prompt and aliases
RUN echo 'export PS1="\e[01;32m\u\e[m:\e[01;34m\w\e[m\$ "' >> /home/bun/.bashrc \
    && echo 'alias cc="claude --dangerously-skip-permissions"' >> /home/devuser/.bashrc \
    && echo 'alias c="claude"' >> /home/devuser/.bashrc

ENV DEVCONTAINER=true
WORKDIR /workspace
