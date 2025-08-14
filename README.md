# devcontainers

This is a set of devcontainers I use for work & experimentation.

## Bash

I am a dinosaur! Bash is just fine for me...

## Claude Code

The devcontainers are pre-configured to use Claude Code. This assumes you are using WSL2 on Windows, although it probably works on any *nix environment. It mounts your user `.claude` folder into the container to reuse settings & authentication tokens.

- Alias `c`: `claude`
- Alias `cc`: `claude --dangerously-skip-permissions`

> [!WARNING]
> The devcontainer has network access! Be very careful with `cc`, as it can wreck havoc!
