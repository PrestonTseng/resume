#!/bin/bash
set -Eeuo pipefail

IMAGE_NAME="resume-generator"
CONTAINER_NAME="resume-generator-$$"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_DIR="$REPO_ROOT/output"
ROOT_PDF="$REPO_ROOT/resume.pdf"

cleanup() {
  docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
}
trap cleanup EXIT

# Build Docker image
echo "Building Docker image..."
docker build -t "$IMAGE_NAME" "$REPO_ROOT"

# Run container to generate resume artifacts
mkdir -p "$OUTPUT_DIR"
find "$OUTPUT_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
echo "Generating resume..."
docker run --name "$CONTAINER_NAME" -v "$OUTPUT_DIR:/app/output" "$IMAGE_NAME"

# In some Docker-in-Docker or remote daemon environments, bind-mounted output may
# be written on the Docker daemon side rather than the caller-visible filesystem.
# Copy from the stopped container as a fallback so generated files are still
# available in ./output.
if ! find "$OUTPUT_DIR" -maxdepth 1 -type f -print -quit | grep -q .; then
  echo "No files visible in ./output after container run; copying from container..."
  docker cp "$CONTAINER_NAME:/app/output/." "$OUTPUT_DIR/"
fi

if ! find "$OUTPUT_DIR" -maxdepth 1 -type f -print -quit | grep -q .; then
  echo "Resume generation failed: no files were produced in ./output" >&2
  exit 1
fi

mapfile -t GENERATED_PDFS < <(find "$OUTPUT_DIR" -maxdepth 1 -type f -name '*.pdf' -print)
if [ "${#GENERATED_PDFS[@]}" -ne 1 ]; then
  echo "Resume generation failed: expected exactly one PDF in ./output, found ${#GENERATED_PDFS[@]}" >&2
  exit 1
fi

# Keep one stable, reviewable distribution artifact beside resume.yaml. Files under
# ./output remain disposable build products; resume.pdf is the tracked publication.
cp "${GENERATED_PDFS[0]}" "$ROOT_PDF"

echo "Resume generated successfully!"
echo "Generated files:"
find "$OUTPUT_DIR" -maxdepth 1 -type f -printf "- %f (%s bytes)\n" | sort
printf '%s\n' "Root publication: resume.pdf ($(stat -c %s "$ROOT_PDF") bytes)"
