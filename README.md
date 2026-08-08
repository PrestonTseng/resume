# Resume

This repository is the source of truth for Preston Tseng's resume/CV.

Career evidence is maintained in `resume_facts.yaml`; the curated default publication is maintained in `resume.yaml` and rendered with [RenderCV](https://rendercv.com/). Docker is used so the output can be regenerated consistently without installing RenderCV or LaTeX directly on the host machine.

## What is in this repo

| Path | Purpose |
| --- | --- |
| `resume_facts.yaml` | Canonical evidence inventory, including provenance, metrics, boundaries, and publication candidates. |
| `resume.yaml` | Curated default resume publication: profile, experience, education, publications, languages, and certifications. |
| `resume.pdf` | Tracked, rendered default resume for immediate review and distribution. |
| `rendercv/settings.yaml` | RenderCV design, typography, page layout, locale, and theme settings. |
| `rendercv/engineeringresumes/` | Custom Typst/Jinja2 templates for the rendered resume theme. |
| `rendercv/markdown/` | Custom Markdown templates for generated Markdown output. |
| `Dockerfile` | Reproducible RenderCV build environment. |
| `script/entrypoint.sh` | Container-side render command. |
| `script/generate-resume.sh` | Host-side helper that builds the Docker image, generates artifacts into `output/`, and refreshes root-level `resume.pdf`. |

## Prerequisites

- Docker
- Bash-compatible shell

No local Python, LaTeX, or RenderCV installation is required when using the Docker workflow.

## Generate the resume

From the repository root:

```bash
./script/generate-resume.sh
```

Disposable generated files are written to:

```text
output/
```

`output/` is intentionally ignored by Git because it contains generated artifacts. The same command also refreshes the tracked `resume.pdf` beside `resume.yaml`.

## Update workflow

1. Update `resume_facts.yaml` when evidence, provenance, metrics, or claim boundaries change.
2. Edit `resume.yaml` when the curated default publication changes.
3. Edit `rendercv/settings.yaml` for visual/layout changes.
4. Edit templates under `rendercv/engineeringresumes/` or `rendercv/markdown/` only when the rendered structure itself needs to change.
5. Run:

   ```bash
   ./script/generate-resume.sh
   ```

6. Review `resume.pdf` and the files under `output/` before publishing or sharing.

## Repository policy

- `resume_facts.yaml` is the canonical career-evidence source; `resume.yaml` is the curated default publication.
- `resume.pdf` is the tracked rendered publication and must be refreshed with every accepted `resume.yaml` or rendering change.
- Generated files under `output/` should not be committed.
- Keep personal contact/profile data accurate and review generated artifacts before distribution.

## License

This is a personal resume repository. See [`LICENSE`](LICENSE) for usage terms.
