# KDE GUI

A library experiment for native KDE applications, with a reusable Rust API and independently importable QML components.

**Status: experimental.** The counter API, CXX-Qt bridge and installed QML module pass automated checks on Fedora 44. Native appearance and assistive-technology acceptance remain unverified.

## Current features

- A dependency-free Rust `Counter` with explicit saturation behavior.
- A read-only observable `CounterState` and a QML `CounterView` with a label and button.
- Qt Quick Controls and Kirigami spacing, independent instances and separate Rust/QML consumers.

Cargo builds the Rust library and bridge. A small CMake wrapper links and installs the QML plugin; a direct Cargo dynamic-library import failed during packaging tests.

## Getting started

Run the Rust foundation tests with `cargo test --locked`. The [build and consumer instructions](docs/BUILDING.md) cover requirements, Qt integration, installation and the QML demonstration. The [technical overview](docs/ARCHITECTURE.md) describes ownership and packaging.

## Roadmap

### Library foundation

- [x] Establish the experimental Rust API and QML components.
- [x] Verify both from separate applications.

### KDE integration

- [x] Verify local module installation and independent imports on Fedora.
- [ ] Check themes, scaling, keyboard navigation and accessibility.

### Example application

- [ ] Build a small KDE showcase using the public API.
- [ ] Document setup and usage from a separate project.

## Documentation

[Technical overview](docs/ARCHITECTURE.md) · [Project decisions](docs/DECISIONS.md) · [Dependencies](docs/DEPENDENCIES.md) · [Appearance and accessibility](docs/THEME_SUPPORT.md) · [Changelog](changelog/README.md)

## Contributions

Focused documentation, packaging research and API feedback are welcome. Planned work and open questions are listed in [project decisions](docs/DECISIONS.md).

## Licensing

Dual-licensed under [MIT](LICENSE-MIT) **OR** [Apache 2.0](LICENSE-APACHE). Dependencies retain their own licences.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
