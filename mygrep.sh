#!/bin/bash
# This script is a custom grep: mygrep

# Help function
help() {
    echo "Usage: $0 [-v] [-n] pattern filename"
    echo "Options:"
    echo "  -v      Invert match (show non-matching lines)"
    echo "  -n      Show line numbers"
    echo "  -h      Display this help message"
    exit 1
}
# Show help if first argument is -h or --help
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    help
fi

# Check for no arguments
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    help
fi

# Options
invert=0
line_number=0

# Parse options
while getopts ":vn" opt; do
    case $opt in
        v) invert=1 ;;
        n) line_number=1 ;;
        \?) echo "Error: Invalid option -$OPTARG"; exit 1 ;;
    esac
done

shift $((OPTIND-1))

# Check arguments after options
if [ $# -eq 0 ]; then
    echo "Error: Missing both pattern and filename."
    help
elif [ $# -eq 1 ]; then
    # Check if the single argument is a valid file (implies missing pattern)
    if [ -f "$1" ]; then
        echo "Error: Missing search pattern. Did you forget to include it?"
    else
        echo "Error: Missing filename or invalid filename."
    fi
    help
elif [ $# -ne 2 ]; then
    echo "Error: Too many arguments."
    help
fi

pattern=$1
filename=$2

# Validate filename
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Perform search with awk
awk -v invert="$invert" -v line_number="$line_number" -v pattern="$pattern" '
BEGIN { IGNORECASE = 1 }
{
    if ((invert && $0 !~ pattern) || (!invert && $0 ~ pattern)) {
        if (line_number) {
            print NR ":" $0
        } else {
            print $0
        }
    }
}' "$filename"
-- INSERT --    
