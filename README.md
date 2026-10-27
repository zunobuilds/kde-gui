# KDE GUI

A planned library for native KDE applications, with a reusable Rust API and independently importable QML components.

**Status: planning only.** No installable library or runnable demo yet.

## Planned features

- Rust state connected to QML through CXX-Qt.
- Native KDE appearance using Qt 6 and QML/Kirigami.
- Keyboard support, accessibility and separate consumer examples.

The build will start with Cargo. CMake will be considered only if QML packaging tests justify it.

## Getting started

Build requirements and usage instructions will be published with the first working version. The [technical overview](docs/ARCHITECTURE.md) describes the planned stack and library boundaries.

## Roadmap

### Library foundation

- [ ] Establish the Rust API and QML components.
- [ ] Verify both from separate applications.

### KDE integration

- [ ] Verify packaging and module installation on Fedora KDE.
- [ ] Check themes, scaling, keyboard navigation and accessibility.

### Example application

- [ ] Build a small KDE showcase using the public API.
- [ ] Document setup and usage from a separate project.

## Documentation

[Technical overview](docs/ARCHITECTURE.md) · [Project decisions](docs/DECISIONS.md) · [Appearance and accessibility](docs/THEME_SUPPORT.md)

## Contributions

Focused documentation, packaging research and API feedback are welcome. Planned work and open questions are listed in [project decisions](docs/DECISIONS.md).

## Licensing

Dual-licensed under [MIT](LICENSE-MIT) **OR** [Apache 2.0](LICENSE-APACHE). Dependencies retain their own licences.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
