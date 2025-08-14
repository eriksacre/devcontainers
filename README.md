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

## Quick start

```bash
mp project-name project-type
```

- Creates a new project folder in `~/LinuxProjects` (yup, hardcoded for now, this is my setup)
- inits a git repo
- Setups up devcontainer
- Opens VS Code

### Supported project types

- bun
- dotnet8

### Adding mp command to your shell

```bash
curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/mp_command.sh >> ~/.bash_profile && source ~/.bash_profile
```

## The code behind devcontainer setup

Use this one-liner to download and execute the setup script in your project directory:

### For Bun projects:
```bash
curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/dc.sh | bash -s bun
```

### For .NET 8 projects:
```bash
curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/dc.sh | bash -s dotnet8
```

## What it does

The script will:

1. **Download devcontainer configuration files** for your chosen environment (bun or dotnet8)
2. **Create a `.devcontainer` folder** with the appropriate `devcontainer.json` and `Dockerfile`
3. **Download `.editorconfig`** (if it doesn't already exist) for consistent code formatting
4. **Download `.gitattributes`** (if it doesn't already exist) for proper line ending handling

## Manual Setup

If you prefer to download and run the script manually:

```bash
# Download the script
curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/dc.sh -o dc.sh

# Make it executable
chmod +x dc.sh

# Run it with your desired container type
./dc.sh bun
# or
./dc.sh dotnet8
```

## Available Container Types

- **bun** - Bun JavaScript runtime container
- **dotnet8** - .NET 8 development container

## After Setup

1. Open the folder in VS Code
2. Install the "Dev Containers" extension if not already installed
3. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac) and run "Dev Containers: Reopen in Container"
4. VS Code will build and start your development container

## Files Created

The script creates the following files in your project:

```
.devcontainer/
├── devcontainer.json    # Container configuration
└── Dockerfile          # Container image definition
.editorconfig           # Code formatting rules (if not exists)
.gitattributes          # Git line ending configuration (if not exists)
```

## Safety Features

- The script will ask for confirmation before overwriting existing `.devcontainer` folders
- Existing `.editorconfig` and `.gitattributes` files are preserved
- All downloads use HTTPS and verify successful completion

## Requirements

- `curl` command available
- `bash` shell
- VS Code with Dev Containers extension for usage
