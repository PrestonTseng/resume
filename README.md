# Resume

This repository is the source of truth for Preston Tseng's resume/CV.

The resume content is maintained in a single YAML file and rendered into distributable formats with [RenderCV](https://rendercv.com/). Docker is used so the output can be regenerated consistently without installing RenderCV or LaTeX directly on the host machine.

## What is in this repo

| Path | Purpose |
| --- | --- |
| `resume.yaml` | Canonical resume content: profile, experience, education, publications, languages, and certifications. |
| `rendercv/settings.yaml` | RenderCV design, typography, page layout, locale, and theme settings. |
| `rendercv/engineeringresumes/` | Custom Typst/Jinja2 templates for the rendered resume theme. |
| `rendercv/markdown/` | Custom Markdown templates for generated Markdown output. |
| `Dockerfile` | Reproducible RenderCV build environment. |
| `script/entrypoint.sh` | Container-side render command. |
| `script/generate-resume.sh` | Host-side helper that builds the Docker image and generates the resume into `output/`. |

## Prerequisites

- Docker
- Bash-compatible shell

No local Python, LaTeX, or RenderCV installation is required when using the Docker workflow.

## Generate the resume

From the repository root:

```bash
./script/generate-resume.sh
```

The generated files are written to:

```text
output/
```

`output/` is intentionally ignored by Git because it contains generated artifacts.

## Update workflow

1. Edit `resume.yaml` for content changes.
2. Edit `rendercv/settings.yaml` for visual/layout changes.
3. Edit templates under `rendercv/engineeringresumes/` or `rendercv/markdown/` only when the rendered structure itself needs to change.
4. Run:

   ```bash
   ./script/generate-resume.sh
   ```

5. Review the files under `output/` before publishing or sharing.

## Repository policy

- `resume.yaml` is the canonical content source.
- Generated files under `output/` should not be committed unless the repository policy changes later.
- Keep personal contact/profile data accurate and review generated artifacts before distribution.

## License

This is a personal resume repository. See [`LICENSE`](LICENSE) for usage terms.
