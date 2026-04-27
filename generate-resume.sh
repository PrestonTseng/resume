#!/bin/bash

# Build Docker image
echo "Building Docker image..."
docker build -t resume-generator .

# Run container to generate PDF
echo "Generating resume..."
docker run --rm -v "$(pwd)/output:/app/output" resume-generator

echo "Resume generated successfully!"
echo "Check the output directory for your PDF resume."