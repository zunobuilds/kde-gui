# KDE GUI

A planned library for native KDE applications, with a reusable Rust API and independently importable QML components.

**Status: planning only.** No installable library or runnable demo yet.

## Planned features

- Rust state connected to QML through CXX-Qt.
- Native KDE appearance using Qt 6 and QML/Kirigami.
- Keyboard operation, accessibility and independent consumer examples.

The prototype is Cargo-first. CMake will be considered only if QML packaging tests justify it.

KDE GUI, GNOME GUI and Unified GUI remain independent library projects.

## Getting started

Read the [K-001 counter plan](docs/K-001.md) for requirements and acceptance tests. Library setup and usage instructions will follow the first working prototype.

## Roadmap

1. Prove the counter with separate Rust and QML consumers.
2. Verify packaging, themes, keyboard operation and accessibility on Fedora KDE.
3. Add a calculator with math and state in the example, then compare usage across the three independent libraries.

## Documentation

[Purpose and architecture](docs/ARCHITECTURE.md) · [Decisions](docs/DECISIONS.md) · [Theme goals and limitations](docs/THEME_SUPPORT.md)

## Contributions

Design feedback, packaging research and documentation improvements are welcome. Review the [decisions](docs/DECISIONS.md) and keep changes focused.

## Licensing

The project licence is **undecided**. No open-source licence grant is provided yet.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
