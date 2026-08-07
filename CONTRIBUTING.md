# Contributing

This is a personal resume repository, so external contributions are not expected.

## For the repository owner

Use this workflow for changes:

1. Update `resume_facts.yaml` when evidence or claim boundaries change.
2. Edit `resume.yaml` for curated publication updates.
3. Edit `rendercv/settings.yaml` for design/layout changes.
4. Regenerate outputs:

   ```bash
   ./script/generate-resume.sh
   ```

5. Review root-level `resume.pdf` and generated files in `output/`.
6. Commit source/configuration changes together with the refreshed `resume.pdf`; do not commit generated `output/` files.

## Suggested commit style

- `docs: update README`
- `resume: update experience section`
- `style: adjust RenderCV spacing`
- `build: fix Docker resume generation`
