#!/bin/bash

# Make Project (mp) function
# Usage: mp <project_name> <project_type>
mp() {
    # Check if correct number of arguments provided
    if [ $# -ne 2 ]; then
        echo "Usage: mp <project_name> <project_type>"
        echo "Example: mp my-awesome-app bun"
        return 1
    fi

    local project_name="$1"
    local project_type="$2"

    # Create the LinuxProjects directory if it doesn't exist
    mkdir -p ~/LinuxProjects

    # Navigate to LinuxProjects directory
    cd ~/LinuxProjects || {
        echo "Error: Could not navigate to ~/LinuxProjects"
        return 1
    }

    # Check if project directory already exists
    if [ -d "$project_name" ]; then
        echo "Error: Project '$project_name' already exists in ~/LinuxProjects"
        return 1
    fi

    # Create project directory
    mkdir "$project_name" || {
        echo "Error: Could not create project directory '$project_name'"
        return 1
    }

    # Navigate into project directory
    cd "$project_name" || {
        echo "Error: Could not navigate to project directory"
        return 1
    }

    echo "Created project directory: ~/LinuxProjects/$project_name"

    # Initialize git repository
    git init || {
        echo "Error: Git initialization failed"
        return 1
    }

    # Download and execute devcontainer setup script
    echo "Setting up devcontainer for project type: $project_type"
    curl -sSL https://raw.githubusercontent.com/eriksacre/devcontainers/main/dc.sh | bash -s "$project_type" || {
        echo "Error: Devcontainer setup failed"
        return 1
    }

    # Open in VS Code
    code . || {
        echo "Warning: Could not open VS Code. Make sure 'code' command is available in PATH"
    }

    echo "Project '$project_name' created successfully!"
}
