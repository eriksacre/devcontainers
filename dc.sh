#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# GitHub repository details
REPO="eriksacre/devcontainers"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to download a file
download_file() {
    local url="$1"
    local output="$2"

    if curl -sSL "$url" -o "$output"; then
        print_success "Downloaded $(basename "$output")"
    else
        print_error "Failed to download $(basename "$output")"
        exit 1
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 <container-type>"
    echo ""
    echo "Available container types:"
    echo "  bun     - Bun JavaScript runtime container"
    echo "  dotnet8 - .NET 8 container"
    echo ""
    echo "Example:"
    echo "  $0 bun"
    echo "  $0 dotnet8"
}

# Check if argument is provided
if [ $# -eq 0 ]; then
    print_error "No container type specified!"
    echo ""
    show_usage
    exit 1
fi

CONTAINER_TYPE="$1"

# Validate container type
if [ "$CONTAINER_TYPE" != "bun" ] && [ "$CONTAINER_TYPE" != "dotnet8" ]; then
    print_error "Invalid container type: $CONTAINER_TYPE"
    echo ""
    show_usage
    exit 1
fi

print_status "Setting up devcontainer for: $CONTAINER_TYPE"

# Check if .devcontainer already exists
if [ -d ".devcontainer" ]; then
    print_warning ".devcontainer directory already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Aborted by user"
        exit 0
    fi
    rm -rf .devcontainer
fi

# Create .devcontainer directory
print_status "Creating .devcontainer directory..."
mkdir -p .devcontainer

# Download devcontainer files
print_status "Downloading devcontainer configuration files..."
download_file "${BASE_URL}/${CONTAINER_TYPE}/devcontainer.json" ".devcontainer/devcontainer.json"
download_file "${BASE_URL}/${CONTAINER_TYPE}/Dockerfile" ".devcontainer/Dockerfile"

# Download .editorconfig if it doesn't exist
if [ ! -f ".editorconfig" ]; then
    print_status "Downloading .editorconfig..."
    download_file "${BASE_URL}/.editorconfig" ".editorconfig"
else
    print_warning ".editorconfig already exists, skipping download"
fi

# Download .gitattributes if it doesn't exist
if [ ! -f ".gitattributes" ]; then
    print_status "Downloading .gitattributes..."
    download_file "${BASE_URL}/.gitattributes" ".gitattributes"
else
    print_warning ".gitattributes already exists, skipping download"
fi

print_success "Devcontainer setup complete!"
echo ""
print_status "Next steps:"
echo "1. Open this folder in VS Code"
echo "2. Install the 'Dev Containers' extension if not already installed"
echo "3. Press Ctrl+Shift+P and run 'Dev Containers: Reopen in Container'"
echo ""
print_status "Files created/updated:"
echo "  .devcontainer/devcontainer.json"
echo "  .devcontainer/Dockerfile"
if [ ! -f ".editorconfig" ]; then
    echo "  .editorconfig"
fi
if [ ! -f ".gitattributes" ]; then
    echo "  .gitattributes"
fi
