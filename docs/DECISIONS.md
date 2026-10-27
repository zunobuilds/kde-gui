# Decisions and outstanding items

- **ACCEPTED / PLANNED:** KDE P01-P10 (2026-10-25); independent, greenfield KDE-first; Rust/Qt6/QML/Kirigami/CXX-Qt first prototype, Cargo-first; separate Rust and QML importability tests; K-001 before calculator.
- **ACCEPTED / PLANNED:** one independent KDE repo at `/home/zuno/Projects/codex-projects/kde-gui`. GNOME and Unified remain equally first-class but are later, separate projects.
- **PLANNED:** future cross-repository calculator parity, with math/state in examples. Screenshots are local design references, not library assets.
- **PLANNED:** Codex runs via dedicated `kde-gui-codex` launcher with no routine approval prompts, denied outside access, separate auth/config and sandboxed network disabled; must pass actual Fedora checks before agent use.
- **OPEN:** final project/release name, licence, crate name, QML URI, minimum toolchain versions, packaging, external publishing, exact API.
- **UNVERIFIED:** Qt build, Codex effective sandbox, GNOME/Unified compatibility, native UI behavior, installed runtime tools on operator Fedora.

The 2026-10-25 previous bundle is historical. Do not reuse former project code, scripts or licence choices.

The current documentation/publication task explicitly authorizes repository-local Git writes and networking to the existing private `zunobuilds/kde-gui` remote. This supersedes historical no-write/no-network restrictions for this task; it does not verify the planned launcher's confinement or authorize Rust/QML implementation. Operational quota policy is recorded in `AGENTS.md`; controller implementations and session evidence stay local and Git-ignored.
