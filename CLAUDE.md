# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Does

Maintains a canonical career-evidence inventory in `resume_facts.yaml` and generates a curated professional CV from `resume.yaml` in multiple formats (PDF, HTML, Markdown, PNG, Typst) using [RenderCV](https://rendercv.com/), orchestrated via Docker for reproducible builds.

## Build Command

```bash
./script/generate-resume.sh
```

This builds the Docker image (`resume-generator`), runs the container with the output directory mounted, writes disposable generated files to `./output/`, and refreshes the tracked `./resume.pdf` publication.

## Architecture

**Content → Build → Output pipeline:**

1. `resume_facts.yaml` — canonical evidence, provenance, metrics, and claim boundaries
2. `resume.yaml` — curated default CV content (experience, education, skills, publications)
3. `rendercv/settings.yaml` — RenderCV design/layout config (theme, fonts, page format, locale)
4. `script/entrypoint.sh` — runs inside the container: merges publication and settings YAML into `merged_resume.yaml`, invokes `rendercv render`, and copies artifacts to `/app/output`
5. `script/generate-resume.sh` — runs the container, verifies one generated PDF, and refreshes tracked `resume.pdf`
6. `Dockerfile` — Python 3.11-slim + LaTeX packages + `rendercv[full]`

**Custom theme templates** live in `rendercv/engineeringresumes/` (Typst/Jinja2, `.j2.typ`) and `rendercv/markdown/` (`.j2.md`). These override the default RenderCV `engineeringresumes` theme entry-by-entry.

## Key Files

| File | Purpose |
|------|---------|
| `resume_facts.yaml` | Canonical evidence inventory — update before strengthening or correcting publication claims |
| `resume.yaml` | Curated default CV content — edit this to update the publication |
| `resume.pdf` | Tracked rendered default publication |
| `rendercv/settings.yaml` | Design config: theme, fonts, margins, colors |
| `rendercv/engineeringresumes/*.j2.typ` | Typst layout templates per entry type |
| `rendercv/markdown/*.j2.md` | Markdown templates per entry type |
| `script/entrypoint.sh` | YAML merge + rendercv invocation (runs in container) |
| `script/generate-resume.sh` | Host-side Docker build + run wrapper |

## Customization Patterns

- **Evidence changes:** Update `resume_facts.yaml` first, then select publication wording in `resume.yaml`
- **Publication changes:** Edit `resume.yaml`, regenerate, and commit the refreshed `resume.pdf`
- **Layout/spacing/fonts:** Edit `rendercv/settings.yaml`
- **Entry structure** (e.g., how experience entries look): Edit the corresponding `.j2.typ` template in `rendercv/engineeringresumes/`
- **Markdown output structure:** Edit templates in `rendercv/markdown/`

The theme is `engineeringresumes` (Typst-based). Templates use Jinja2 syntax for dynamic fields.
