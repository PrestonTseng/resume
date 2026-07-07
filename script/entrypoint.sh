#!/bin/bash
set -Eeuo pipefail

# Clean generated-output directory from previous runs
mkdir -p output
find output -mindepth 1 -maxdepth 1 -exec rm -rf {} +

# Merge resume.yaml with settings.yaml
echo "Merging CV data with settings..."
cat resume.yaml > merged_resume.yaml
echo "" >> merged_resume.yaml
cat rendercv/settings.yaml >> merged_resume.yaml

# Generate resume using RenderCV
echo "Generating resume..."
rendercv render merged_resume.yaml --output-folder-name output

# Confirm that RenderCV produced at least one PDF.
echo "Generated PDF files:"
find output -name "*.pdf" -print -exec ls -lh {} \;

if ! find output -name "*.pdf" -print -quit | grep -q .; then
  echo "No PDF files found" >&2
  exit 1
fi

# Copy generated PDFs to the output root for easier access.
echo "Copying PDF files to output directory root..."
find output -mindepth 2 -name "*.pdf" -exec cp {} output/ \;

echo "Resume generation complete!"
