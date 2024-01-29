#!/bin/bash

# Check if a filename argument is provided
if [ "$#" -ne 1 ]; then
    echo "Missing filename."
    echo "Useage example: $0 <filename>"
    exit 1
fi

filename=$1

# Check if the file exists in the current directory
if [ ! -f "./$filename" ]; then
    echo "Error: File not found in the current directory."
    exit 1
fi

# Run the Docker container and execute the script
echo "Running the script in the Docker container..."
docker compose run --rm mapnik python3 "/app/$filename"

# Check if the Docker command was successful
if [ $? -ne 0 ]; then
    echo "Error occurred while running the script in Docker."
    exit 1
fi

echo "Process completed successfully."
