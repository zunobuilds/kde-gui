# KDE GUI agent instructions

## Role and scope
Create an independent, reusable, greenfield KDE GUI library. No code, architecture, AGENTS instructions, launchers or telemetry inherited from other projects. Do not implement GNOME GUI, Unified GUI, hardware control or a fourth shared repository here. Retain working behavior, inspect relevant files before proposing changes, and keep dependencies minimal.

## Accepted PLANNED baseline
- Rust + Qt 6 + QML/Kirigami + CXX-Qt is the first prototype. Cargo-first; CMake is conditional on evidence from real import/packaging tests. Versions, crate name, module URI, final licence and public API identifiers remain OPEN.
- Deliver a reusable Rust API **and** independently importable QML components. Demonstrate with separate downstream Rust and QML consumers, not only a demo in the same crate.
- First implementation milestone **K-001**: label/counter, Rust state bridge if appropriate, native KDE appearance, keyboard/accessibility verification and separate consumer proofs. Plan and verify this small milestone before the calculator.
- Later example: runnable calculator (digits, decimal, +, -, *, /, =, clear, safe input/zero-division), with calculator math/state in the example. Design high-level consumer usage for near-parity with future separate GNOME and Unified demos without coupling repositories.
- Never assert instant in-window GTK/Qt swapping or arbitrary global-theme API support without proof.

## Referencing KDE
Inspect `references/kde-system-apps/README.md` and `manifest.json`. Reference PNGs are local user-provided screenshots, not redistributable assets. They demonstrate observed visual layouts only: do not conclude actual runtime Qt, QML, Kirigami or accessibility behavior from pictures. Verify native behavior and theme interactions in Fedora.

## Code and docs
- Implement only the currently authorized bounded task. No speculative giant component framework or premature layer abstractions.
- Prefer maintainable code, focused tests, helpful errors and explicit platform limitations. Dependencies and their licences require review.
- Follow source docs/DECISIONS.md; distinguish PLANNED, EXPERIMENTAL and UNVERIFIED from tested results.
- Keep docs concrete and concise. Do not copy third-party prose/assets or claim builds/reviews passed that were not observed.
- Preserve the README's linked AI credit. `docs/DEVELOPMENT_TOOLS.md` records **skills actually invoked**, with upstream, revision/date and concrete purpose; installed is not used. Initially none recorded.

## Files and security
- Updated operator authorization: edit files and Git metadata inside this KDE repository, commit and push to its own private GitHub repository, and use networking and web research.
- Do not write to directories outside this repository. The explicitly authorized GitHub remote is the only external publication target.
- Do not modify unrelated local or GitHub repositories, global configurations or operating-system packages. No sudo or sandbox bypass.
- Check staged files before pushing. Keep local reference PNGs, downloaded skills, secrets and .work/ out of Git.
- Preserve the independent greenfield library and truthful development evidence.

## Local telemetry / checkpoints
- Retain reviewed local `tools/telemetry/telemetry.py` and any local timing/supervisor tooling. Keep all telemetry/controller source, configurations, tests and logs Git-ignored; outputs belong under `.work/`. Do not store raw prompts, secrets, complete personal paths or command env dumps.
- Telemetry isn't independent proof: agents can alter their own `.work/` records. Clearly identify evidence collected by the operator vs agent-produced records.
- Current operator usage policy supersedes the historical 13%/8% thresholds: check both actual five-hour and weekly windows and apply the stricter remaining percentage. Above 15% continue; above 9% through 15% conserve; at or below 9% stop new work; at or below 1% preserve the emergency safeguard. Unknown, stale or unavailable usage fails closed for new workloads; finish at most one bounded safe checkpoint. Never fabricate percentages/reset times, redeem resets automatically or claim active enforcement from prompt instructions or synthetic tests alone.
- Report Git SHA + dirty state, phase timing and test results if observable. Missing values remain unknown, no guessed performance numbers.

## Execution gate
- First task may improve repository documentation and organization, create a private GitHub repository, commit and push, and plan K-001. No Rust/QML implementation or calculator coding yet.
