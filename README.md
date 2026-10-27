# KDE GUI

KDE GUI is a planned library for building applications that feel at home on the KDE desktop. The goal is to make native interfaces reusable through a Rust API and QML components that developers can import independently.

**Status: planning only.** This repository contains design decisions and milestone plans. There is no installable library or runnable demo yet.

## Planned features

- Reusable components for both Rust applications and independent QML consumers.
- Native KDE appearance through Qt and Kirigami controls, including fonts, colors and scaling.
- Keyboard operation and accessibility checks built into the first milestone.
- Small examples that demonstrate how to use the library in a separate application.

## Technology

The first prototype will use **Rust, Qt 6, QML/Kirigami and CXX-Qt**. Rust will own application state, QML will handle presentation, and a narrow CXX-Qt bridge will connect them.

The build starts with Cargo. CMake will be considered only if independent QML packaging tests show it is needed. Versions and public API names remain open.

KDE GUI, GNOME GUI and Unified GUI are separate library projects. Future examples will compare their high-level usage while keeping each library independent.

## Getting started

You can explore the plans and help shape the first prototype today. With access to this private repository, clone it and check documentation edits with Git:

```sh
git clone https://github.com/zunobuilds/kde-gui.git
cd kde-gui
git diff --check
```

`git diff --check` catches whitespace errors in your edits; Qt is not needed for documentation work. Library setup and usage instructions will follow the first working prototype. The [K-001 plan](docs/K-001.md) covers its requirements and acceptance tests.

## Roadmap

1. Build the K-001 label/counter with Rust state updates and separate downstream Rust and QML consumers.
2. Verify packaging, native themes, keyboard operation and accessibility on Fedora KDE before moving beyond K-001.
3. Add a calculator example with its own math and state, then compare developer workflows across the independent KDE, GNOME and Unified libraries.

## Documentation

- [Project purpose and architecture](docs/ARCHITECTURE.md) and [accepted decisions](docs/DECISIONS.md) — the technical direction and choices still open.
- [K-001 implementation plan](docs/K-001.md) — the counter milestone, dependency review and validation criteria.
- [Theme support](docs/THEME_SUPPORT.md) — native appearance goals and current limitations.

## Contributions

Contributions are welcome. At this stage, design feedback, dependency and packaging research, and clearer documentation are especially useful.

Start with the [accepted decisions](docs/DECISIONS.md), keep changes focused, and explain what you changed and how you checked it. Discuss API or dependency changes before implementation, and keep credentials and local reference material out of Git.

## Licensing

The project licence is **undecided**; no open-source licence grant is provided yet. Dependency licences will also be reviewed before implementation and distribution.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
