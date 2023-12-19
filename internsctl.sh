#!/bin/bash

# internsctl - Custom Linux command for various operations

# Function to display the manual page
display_manual() {
    echo "internsctl - Custom Linux command for various operations"
    echo
    echo "USAGE:"
    echo "  internsctl [command] [options]"
    echo
    echo "COMMANDS:"
    echo "  cpu getinfo        Display CPU information"
    echo "  memory getinfo     Display memory information"
    echo "  user create        Create a new user"
    echo "  user list [options] List users"
    echo "  file getinfo       Get information about a file"
    echo
    echo "OPTIONS:"
    echo "  --sudo-only        List users with sudo permissions"
    echo "  --size, -s         Print file size"
    echo "  --permissions, -p  Print file permissions"
    echo "  --owner, -o        Print file owner"
    echo "  --last-modified, -m Print last modified time"
    echo "  --version          Display command version"
    echo "  --help             Display this help message"
    echo
}

# Function to display version
display_version() {
    echo "internsctl v0.1.0"
}

# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free
}

# Function to create a new user
create_user() {
    if [ $# -eq 0 ]; then
        echo "Error: Please provide a username."
    else
        sudo useradd -m $1
        echo "User '$1' created successfully."
    fi
}

# Function to list users
list_users() {
    if [ "$1" == "--sudo-only" ]; then
        getent group sudo | cut -d: -f4
    else
        cut -d: -f1 /etc/passwd
    fi
}

# Function to get file information
get_file_info() {
    local file=$1
    shift

    if [ ! -e "$file" ]; then
        echo "Error: File '$file' not found."
    else
        local output="File: $file"
        
        while [ $# -gt 0 ]; do
            case "$1" in
                "--size" | "-s" )
                    output="$output Size(B): $(stat -c %s "$file")"
                    ;;
                "--permissions" | "-p" )
                    output="$output Access: $(stat -c %A "$file")"
                    ;;
                "--owner" | "-o" )
                    output="$output Owner: $(stat -c %U "$file")"
                    ;;
                "--last-modified" | "-m" )
                    output="$output Modify: $(stat -c %y "$file")"
                    ;;
                * )
                    echo "Error: Invalid option '$1'."
                    exit 1
                    ;;
            esac
            shift
        done

        echo "$output"
    fi
}

# Main script

case "$1" in
    "cpu" )
        case "$2" in
            "getinfo" )
                get_cpu_info
                ;;
            * )
                echo "Error: Invalid command. Usage: internsctl cpu getinfo"
                ;;
        esac
        ;;
    "memory" )
        case "$2" in
            "getinfo" )
                get_memory_info
                ;;
            * )
                echo "Error: Invalid command. Usage: internsctl memory getinfo"
                ;;
        esac
        ;;
    "user" )
        case "$2" in
            "create" )
                create_user "$3"
                ;;
            "list" )
                list_users "$3"
                ;;
            * )
                echo "Error: Invalid command. Usage: internsctl user create <username>"
                echo "       internsctl user list [--sudo-only]"
                ;;
        esac
        ;;
    "file" )
        case "$2" in
            "getinfo" )
                shift 2
                get_file_info "$@"
                ;;
            * )
                echo "Error: Invalid command. Usage: internsctl file getinfo [options] <file-name>"
                ;;
        esac
        ;;
    "--version" )
        display_version
        ;;
    "--help" )
        display_manual
        ;;
    * )
        echo "Error: Invalid command. Use 'internsctl --help' for usage instructions."
        ;;
esac
