# Contributing

This is a personal resume repository, so external contributions are not expected.

## For the repository owner

Use this workflow for changes:

1. Edit `resume.yaml` for content updates.
2. Edit `rendercv/settings.yaml` for design/layout changes.
3. Regenerate outputs:

   ```bash
   ./script/generate-resume.sh
   ```

4. Review generated files in `output/`.
5. Commit only source files and configuration, not generated `output/` files.

## Suggested commit style

- `docs: update README`
- `resume: update experience section`
- `style: adjust RenderCV spacing`
- `build: fix Docker resume generation`
