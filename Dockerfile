FROM python:3.11-slim-bookworm

# Install minimal LaTeX packages for PDF generation
RUN apt-get update && apt-get install -y \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-latex-extra \
    && rm -rf /var/lib/apt/lists/*

# Install RenderCV with full features
RUN pip install "rendercv[full]"

# Set working directory
WORKDIR /app

# Copy YAML files
COPY resume.yaml .
COPY rendercv/ ./rendercv/


# Copy executable script
COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]