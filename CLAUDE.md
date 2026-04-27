# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Does

Generates a professional CV in multiple formats (PDF, HTML, Markdown, PNG, Typst) from a single YAML source file using [RenderCV](https://rendercv.com/), orchestrated via Docker for reproducible builds.

## Build Command

```bash
./generate-resume.sh
```

This builds the Docker image (`resume-generator`), runs the container with the output directory mounted, and writes all generated files to `./output/`.

## Architecture

**Content → Build → Output pipeline:**

1. `resume.yaml` — all CV content (experience, education, skills, publications)
2. `rendercv/settings.yaml` — RenderCV design/layout config (theme, fonts, page format, locale)
3. `entrypoint.sh` — runs inside the container: merges the two YAML files into `merged_resume.yaml`, invokes `rendercv render`, copies the PDF to `/app/output`
4. `Dockerfile` — Python 3.11-slim + LaTeX packages + `rendercv[full]`

**Custom theme templates** live in `rendercv/engineeringresumes/` (Typst/Jinja2, `.j2.typ`) and `rendercv/markdown/` (`.j2.md`). These override the default RenderCV `engineeringresumes` theme entry-by-entry.

## Key Files

| File | Purpose |
|------|---------|
| `resume.yaml` | CV content — edit this to update the CV |
| `rendercv/settings.yaml` | Design config: theme, fonts, margins, colors |
| `rendercv/engineeringresumes/*.j2.typ` | Typst layout templates per entry type |
| `rendercv/markdown/*.j2.md` | Markdown templates per entry type |
| `entrypoint.sh` | YAML merge + rendercv invocation (runs in container) |
| `generate-resume.sh` | Host-side Docker build + run wrapper |

## Customization Patterns

- **Content changes:** Edit `resume.yaml` only
- **Layout/spacing/fonts:** Edit `rendercv/settings.yaml`
- **Entry structure** (e.g., how experience entries look): Edit the corresponding `.j2.typ` template in `rendercv/engineeringresumes/`
- **Markdown output structure:** Edit templates in `rendercv/markdown/`

The theme is `engineeringresumes` (Typst-based). Templates use Jinja2 syntax for dynamic fields.
