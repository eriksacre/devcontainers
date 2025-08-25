# devcontainers

This is a set of devcontainers I use for work & experimentation.

## My environment

- Windows 11 with WSL2
- Using Bash in WSL2
- Claude Code is installed in WSL2. This is relevant as we will mount the `.claude` folder in devcontainers
- Using VS Code as my editor (actually VS Code Insiders, but 'code' is defined as alias)

## Claude Code

The devcontainers are pre-configured to use Claude Code. This assumes you are using WSL2 on Windows, although it probably works on any *nix environment. It mounts your user `.claude` folder into the container to reuse settings & authentication tokens.

- Alias `c`: `claude`
- Alias `cc`: `claude --dangerously-skip-permissions`

> [!WARNING]
> The devcontainer has network access! Be very careful with `cc`, as it can wreack havoc!

## Docker outside of Docker

The devcontainers are configured to use Docker outside of Docker, which means you can use the docker command in the container, and it actually uses the host's Docker. By having Docker outside of Docker we can also build a container for the application under development.

## Quick start

```bash
mp project-name project-type
```

- Creates a new project folder in the current folder
- Inits a git repo
- Setups up devcontainer
- Opens VS Code

### Supported project types

- **bun** - Bun JavaScript runtime container
- **dotnet8** - .NET 8 development container

#### Recommended C# project settings

```xml
<Project>
  <PropertyGroup>
    <LangVersion>latest</LangVersion>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <TreatWarningsAsErrors>true</TreatWarningsAsErrors> <!-- optional but strict -->
    <EnableNETAnalyzers>true</EnableNETAnalyzers>
    <AnalysisLevel>latest</AnalysisLevel> <!-- keep rules current -->
  </PropertyGroup>
</Project>
```

### Adding mp command to your shell

```bash
curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/mp_command.sh >> ~/.bashrc && source ~/.bashrc
```

If you installed the command and you want to update it to the current version: `mp_update`

## The code behind devcontainer setup

> [!NOTE]
> When using the mp command, this happens automatically behind the scenes.

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
