# KDE GUI agent instructions

# KDE GUI agent instructions

## Authority and scope
- Develop **only** this independent KDE GUI library; do not inherit other projects' code/rules or implement GNOME, cross-toolkit unification, hardware control or shared repositories here. Follow source and `docs/DECISIONS.md`; preserve working behavior and agreed decisions, distinguishing PLANNED/EXPERIMENTAL/UNVERIFIED from proven results. Avoid unauthorized features and needless abstraction.
- **K-001:** Rust counter, CXX-Qt bridge, QML view, tests and independent consumers exist. Finish and record **actual Fedora KDE** theme/font, scaling, physical-keyboard and audible-accessibility acceptance per `docs/THEME_SUPPORT.md`; fix verified defects. Synthetic/agent tests do not replace manual evidence.
- Task-list showcase proposed; calculator remains an option with locally recorded requirements. **Neither is authorized yet.** Do not claim arbitrary Global Theme support or live GTK/Qt switching without proof.

## Codex, permissions and Git
- Use the operator's **full-access Codex CLI**. No custom launcher, assumed sandbox, automatic quota monitor or new configuration requirements. Full access is **not** permission to exceed these rules.
- **Request and receive explicit permission before deliberately accessing any file outside this repository**, whether reading, inspecting, writing, moving or deleting; specify the external scope and never assume standing consent. Includes other projects, home/parent directories and system configuration. Normal toolchain/OS loading is exempt, not deliberate file inspection. No `sudo`, system installations or host changes without permission. Keep work/caches/tools project-local and ignored where practical.
- Public web research and read-only GitHub access are allowed. **Local staging/commits are permitted** after diff review. **Every remote write** (push, branch/tag, release, issue/PR change) needs explicit user approval first. Do not force-push, rewrite published history or alter unrelated repositories. Keep secrets, local screenshots, downloaded skills and `.work/` untracked; track `AGENTS.md` and `changelog/`.

## Five-hour usage
Use the **latest user-reported remaining percentage**: **<30%: check in every 15 minutes** of sustained work; **≥30%: every 30 minutes**. No timed check-in for shorter runs; users may update between prompts. If none was reported and work will be sustained, ask once for the percentage.

At each check-in **save progress, summarize work/findings, ask for the updated percentage and wait for a reply**. Keep ordinary progress updates separate. Never guess usage, impose automatic quotas, require telemetry or redeem resets automatically.

## Technical and evidence rules
- **Rust + Qt 6 + QML/Kirigami + CXX-Qt**, Cargo-first; minimal CMake wrapper justified by failed direct QML-plugin import. Deliver reusable Rust and independently importable QML APIs, verified by separate consumers. Versions, public names, URI and install layout remain experimental.
- Original code/docs: **MIT OR Apache-2.0**; preserve dependency licences/notices and review binary redistribution before release. Prefer correctness, simplicity, maintainability, security, focused tests and explicit limitations. Inspect before editing; report only tests actually run.
- Relevant KDE references: `references/kde-system-apps/README.md` and `manifest.json` if present. User reference PNGs are nonredistributable visual guides, **not** runtime/toolkit/accessibility proof.
- Consult `.work/plans/KDE_GUI_INITIAL_IMPLEMENTATION.md`, `docs/K-001.md` and checkpoints when present; on fresh clones rely on tracked source/docs without inventing gates. Keep plans, tools, logs and checkpoints ignored (prefer `.work/`); avoid secrets, prompts, personal paths and environment dumps. Distinguish operator observations, agent evidence and unverified reports. Record Git SHA/dirty state, changes, tests, outcomes and blockers when observable; never invent evidence.

## Public documentation and changelog
- Write concise, original, neutral documentation for contributors, **not personal messages to the owner** (avoid “your project”, “you wanted”, “as requested”). Keep internal milestone plans and cross-project discussions out of reader-facing docs. Preserve linked README AI credit; `docs/DEVELOPMENT_TOOLS.md` lists **only used skills**, with upstream, revision/date and purpose.
- Log every meaningful public change **in its local commit** under `changelog/`. Use **Asia/Singapore (UTC+08:00)** dates: one `DD-MM-YY.md` per active day, headed `# DD/MM/YY`, concise nonempty Added/Changed/Fixed/Removed sections. Keep `changelog/README.md` newest-first with all relative links and the root README link. Backfill only Git-verified Singapore commit dates; exclude private/internal or unverified details. No changelog automation. **Never push without approval.**
