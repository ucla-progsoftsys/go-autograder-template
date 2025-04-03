#!/bin/bash

# Default: run in normal mode
debug_mode=false

# Parse command line options
while getopts "d" opt; do
    case ${opt} in
        d )
            debug_mode=true
            ;;
        \? )
            echo "Usage: $0 [-d]"
            exit 1
            ;;
    esac
done

if [ "$debug_mode" = true ]; then
    # Debug mode: run interactive shell + don't use build cache
    docker build -t go-autograder --no-cache . -f go-autograder/Dockerfile
    docker run --platform=linux/amd64 -it --rm -v ./submission:/autograder/submission -v ./results:/autograder/results go-autograder /bin/bash
else
    # Normal mode: run the autograder
    docker build -t go-autograder . -f go-autograder/Dockerfile
    docker run --platform=linux/amd64 --rm -v ./submission:/autograder/submission -v ./results:/autograder/results go-autograder /autograder/run_autograder
fi