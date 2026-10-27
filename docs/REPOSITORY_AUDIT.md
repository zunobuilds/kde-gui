# Repository organization audit

Documentation audit: 2026-10-27. No source implementation exists. Preserve the small root: README for orientation, docs for decisions and evidence, source directories only when implementation is approved.

## Retained structure

- Keep `src/` and `qml/` as future implementation boundaries; do not create a multi-crate workspace before packaging evidence requires it.
- Keep `examples/` for application behavior and `smoke/` for independent consumer projects. Use `tests/` for focused library integration tests. Define commands when real files exist.
- Preserve `docs/DECISIONS.md` as the decision record, architecture and theme documents as focused references, and installed skill provenance separately from actual skill usage.
- Preserve screenshot files and provenance in place. Exclude the entire local reference intake from publication because its metadata also includes local filenames and environment details. The README explains its local role.
- Preserve `.agents/skills/`, local tooling and `.work/` records in place. Exclude downloaded skills and all telemetry/controller source, configurations, tests and outputs from Git. Retain historical launcher checks and task checkpoints locally as well.
- Do not add CI, packaging layers, a shared repository or empty marker files before there is something meaningful to build or distribute.

## Documentation delivered

README separates current status from planned features and includes setup, documentation checks, contributions and licensing limitations. `K-001.md` carries the bounded implementation and acceptance plan. `RESEARCH.md` records six candidates and explains why the required live repository study remains incomplete. No research-derived design choices are claimed.

## Publication review

Publish an explicit file allowlist after staged review. Exclude screenshots, intake metadata, credentials, local credential fixture directories, caches, downloaded skills, telemetry/controller materials and `.work/`. There were no previously tracked files to untrack at the start of this checkpoint. Preserve existing local tooling; improve it only within the authorized scope. Verify the existing `zunobuilds/kde-gui` remote is private before pushing and verify the exact commit afterward.

Historical containment and first-task language in older documents is retained as provenance. Current operator authorization permits documentation and private publication, but does not constitute evidence that native Fedora confinement passed. Implementation stays gated.
