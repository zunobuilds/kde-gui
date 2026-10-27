# KDE GUI agent instructions

## Current Codex workflow (27/10/26; supersedes older execution gates)

- KDE GUI source implementation is authorized. The retired custom launcher and its operator-observed containment checklist are historical/deferred, **not prerequisites** to planning, source edits, builds or tests. Do not claim the old launcher was validated.
- Use standard Codex CLI in its actual active sandbox and follow its technical boundaries. No sudo, no sandbox bypass and no edits to unrelated repositories.
- The **global external `codex-run` launcher**, not this agent or any local telemetry script, is responsible for the 5-hour and weekly quota policy: conserve at 15% remaining, stop at 9% remaining. Do **not** ask for manual percentages/reset times, pause ordinary project work due to agent-side unknown readings, or claim that prompts enforce these limits. If the launcher cannot query both windows, it refuses to start or continue the session. Never automatically redeem quota resets.
- In `workspace-write`, `.git/` is protected. Do not repeatedly attempt Git commits or approval-required GitHub MCP write actions with approval policy `never`. Implement and test inside the workspace; report exact reviewed files so a normal terminal can perform Git staging, commits and pushes outside the Codex sandbox.
- Keep the full plan and operational checkpoints Git-ignored; keep `AGENTS.md` and the public daily changelog tracked. Preserve all existing technical decisions.

## Role and scope
Create an independent, reusable, greenfield KDE GUI library. No code, architecture, AGENTS instructions, launchers or telemetry inherited from other projects. Do not implement other desktop-toolkit libraries, cross-toolkit unification, hardware control or a fourth shared repository here. Retain working behavior, inspect relevant files before proposing changes, and keep dependencies minimal.

## Accepted PLANNED baseline
- Rust + Qt 6 + QML/Kirigami + CXX-Qt is the first prototype. Cargo-first; CMake is conditional on evidence from real import/packaging tests. Versions, crate name, module URI and public API identifiers remain OPEN.
- Project-owned code and documentation use `MIT OR Apache-2.0`. Preserve dependency licences and third-party notices; local reference screenshots are excluded from this grant.
- Deliver a reusable Rust API **and** independently importable QML components. Demonstrate with separate downstream Rust and QML consumers, not only a demo in the same crate.
- First implementation milestone **K-001**: label/counter, Rust state bridge if appropriate, native KDE appearance, keyboard/accessibility verification and separate consumer proofs. Plan and verify this small milestone before the calculator.
- A calculator remains a possible later example; a small task-list app is now proposed as a broader showcase. The example choice is open. Preserve the earlier calculator requirements in local planning records; no example implementation is authorized by the documentation cleanup.
- Never assert instant in-window GTK/Qt swapping or arbitrary global-theme API support without proof.

## Referencing KDE
Inspect `references/kde-system-apps/README.md` and `manifest.json`. Reference PNGs are local user-provided screenshots, not redistributable assets. They demonstrate observed visual layouts only: do not conclude actual runtime Qt, QML, Kirigami or accessibility behavior from pictures. Verify native behavior and theme interactions in Fedora.

## Code and docs
- Implement only the currently authorized bounded task. No speculative giant component framework or premature layer abstractions.
- Prefer maintainable code, focused tests, helpful errors and explicit platform limitations. Dependencies and their licences require review.
- Follow source docs/DECISIONS.md; distinguish PLANNED, EXPERIMENTAL and UNVERIFIED from tested results.
- Keep docs concrete and concise. Do not copy third-party prose/assets or claim builds/reviews passed that were not observed.
- Preserve the README's linked AI credit. `docs/DEVELOPMENT_TOOLS.md` records **skills actually invoked**, with upstream, revision/date and concrete purpose; installed skills do not count as use.

## Files and security
- Updated operator authorization: edit files and Git metadata inside this KDE repository, commit and push to `zunobuilds/kde-gui`, and use networking and web research. The operator intentionally made this repository public.
- Do not write to directories outside this repository. The explicitly authorized GitHub remote is the only external publication target.
- Do not modify unrelated local or GitHub repositories. No sudo or sandbox bypass.
- Check staged files before pushing. Keep local reference PNGs, downloaded skills, secrets and .work/ out of Git.
- Preserve the independent greenfield library and truthful development evidence.

## Active development sandbox
- Use standard Codex CLI with `--sandbox workspace-write --ask-for-approval never` and the actual session permission profile. Keep the sandbox enabled; do not request escalation or change external configuration to bypass a denial.
- The former custom launcher is retired. Its operator-observed confinement verification is **NOT PERFORMED / DEFERRED**, never PASSED, and is not a prerequisite for saving plans, editing source, building or testing. Do not request confirmation of this already-authorized correction.
- Workspace-write is not proof of repository-only read isolation, parent/sibling read denial or custom-launcher confinement. Temporary directories and other roots can depend on the active profile. Repository-only writes remain project policy even where the runtime permits additional locations. Report actual access failures without inventing confinement tests.
- Preserve historical security records as historical evidence. Superseded launcher requirements in ignored records or archives cannot reinstate an implementation gate. Native GUI, keyboard and accessibility validation remain required product checks.

## Local telemetry / checkpoints
- Retain reviewed local `tools/telemetry/telemetry.py` and any local timing/supervisor tooling. Keep all telemetry/controller source, configurations, tests and logs Git-ignored; outputs belong under `.work/`. Do not store raw prompts, secrets, complete personal paths or command env dumps.
- Telemetry isn't independent proof: agents can alter their own `.work/` records. Clearly identify evidence collected by the operator vs agent-produced records.
- Usage policy is separate from sandbox verification. Do not claim automatic quota enforcement by the standard CLI, prompt instructions or retained local supervisor without observed integration. Use a supported available usage source; do not repeatedly request manual readings.
- Report Git SHA + dirty state, phase timing and test results if observable. Missing values remain unknown, no guessed performance numbers.

## Authorized implementation scope
- The documentation-only first-task restriction is superseded. Resume the approved K-001 label/counter implementation plan under the active sandbox and the separate usage policy, without another confinement question or implementation approval request.
- Read the complete ignored plan at `.work/plans/KDE_GUI_INITIAL_IMPLEMENTATION.md` when available, otherwise `docs/K-001.md`, together with the current local checkpoint. A fresh clone may lack these local files; reconstruct the bounded plan from this baseline and `docs/DECISIONS.md` without restoring a launcher gate.
- Preserve the accepted technical decisions and complete implementation plan. Later showcase/calculator coding remains outside this bounded implementation authorization.

### Repository documentation voice

Write all repository-facing content in a neutral, professional, project-oriented voice.

- Never address the repository owner personally.
- Do not use phrases such as "your project", "you wanted", "as you requested", or "we decided together".
- Write documentation for contributors, developers and users, not as a personal response to the owner.
- Describe technical decisions objectively, including their rationale and limitations.
- Prefer "The library provides..." or "Contributors should..." over conversational explanations.
- Keep AI assistance disclosures factual and consistent with `docs/DEVELOPMENT_TOOLS.md`.
- These rules apply to README files, documentation, code comments, changelogs and commit messages.
- Conversational responses in Codex sessions are unaffected.

## Public documentation boundary
- Track `AGENTS.md` as shared repository instructions. Keep K-001 internal plans local and Git-ignored. Reader-facing documentation focuses on the KDE library, with no internal milestone IDs or cross-project discussion. Any later comparison belongs in a separately authorized file.
- Use neutral project wording; avoid conversational licence phrasing outside unchanged standard licence texts.

## Daily changelog maintenance

- Maintain the tracked `changelog/` directory for every meaningful public repository change, including documentation and licensing changes, in the same commit as the change.
- Use Singapore calendar dates: `Asia/Singapore`, SGT, UTC+08:00; day boundaries are local midnight to midnight. Any included times use 24-hour notation with the `+08:00` offset.
- Use exactly one `DD-MM-YY.md` file for each active day, with `# DD/MM/YY` as its first heading. Update the existing file for further same-day changes; never create duplicate, empty or inactive-day files.
- Keep `changelog/README.md` complete and sorted by actual date, newest first, with relative links to every daily file. Preserve the short Changelog link in the root README.
- Group concise, neutral public-facing bullets under relevant Added, Changed, Fixed and Removed headings. Omit empty categories and repeated entries.
- Backfill only changes verified from Git history; use committer timestamps converted to Asia/Singapore. Do not infer activity from dates in planning documents.
- Exclude internal agent operations, telemetry, private paths, credentials, routine commands and internal milestone identifiers. Preserve the existing public documentation boundary.
- Keep changelog files and `AGENTS.md` tracked. Maintain the system manually; no changelog generator, scheduler or other automation is required.
