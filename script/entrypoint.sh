#!/bin/bash

# Merge resume.yaml with settings.yaml
echo "Merging CV data with settings..."
cat resume.yaml > merged_resume.yaml
echo "" >> merged_resume.yaml
cat rendercv/settings.yaml >> merged_resume.yaml

# Generate PDF using RenderCV
echo "Generating PDF resume..."
rendercv render merged_resume.yaml --output-folder-name output

# Find the generated PDF and copy to output root
echo "Moving PDF to output directory..."
find output -name "*.pdf" -exec cp {} output/ \;

echo "Resume generation complete!"
echo "PDF files generated:"
ls -la output/*.pdf 2>/dev/null || echo "No PDF files found"