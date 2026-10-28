# Contributing

KDE GUI is an experimental Rust and QML library. Focused bug fixes, documentation improvements, packaging research and API feedback are welcome. Read the [project decisions](docs/DECISIONS.md) before proposing architectural changes; larger components and showcase applications need scope discussion first.

## Development setup

Clone the repository and follow the [build instructions](docs/BUILDING.md). The default Rust API needs no Qt SDK. QML work needs the Linux Qt/Kirigami toolchain described there. The [technical overview](docs/ARCHITECTURE.md) explains state ownership and plugin packaging.

## Reporting problems

Search [existing issues](https://github.com/zunobuilds/kde-gui/issues) before opening a report. Include:

- The Git revision, operating system and relevant Rust, Qt and Kirigami versions.
- Minimal reproduction steps, expected behavior and actual behavior.
- The command used and relevant sanitized diagnostics.
- For visual or input issues, the desktop session, controls style, color scheme, font and display scale.

Use issues for usage questions and feature proposals too. Describe the problem and intended outcome before proposing an API. Remove credentials and personal data from logs and screenshots. Do not post sensitive vulnerability details in public issues.

## Checks

From the repository root, run the default Rust checks:

```sh
cargo test --locked
cargo fmt --all -- --check
cargo fmt --manifest-path smoke/rust-consumer/Cargo.toml -- --check
cargo run --manifest-path smoke/rust-consumer/Cargo.toml --locked
git diff --check
```

Rustfmt must be installed for formatting checks. For Qt, QML or packaging changes, also run the [QML build and CTest suites](docs/BUILDING.md#qml-module), [independent package checks](docs/BUILDING.md#independent-package-checks) and relevant [Clippy, Rustdoc and QML lint checks](docs/BUILDING.md#additional-checks-and-tool-issues). The latter need Clippy, Rustdoc, LLVM LLD and Qt's QML lint tool.

For appearance, keyboard or accessibility changes, use the [native verification checklist](docs/THEME_SUPPORT.md#manual-checklist). Record the environment and distinguish automated, synthetic and manual observations. Headless success does not establish visible appearance or screen-reader speech. State checks that could not be run and why.

## Pull requests

Keep changes focused and describe the concrete problem, resulting behavior, checks performed and remaining limitations. Link related issues when applicable. Update the relevant documentation and the [daily changelog](changelog/README.md) in the same change, using the Singapore calendar date and keeping the index newest first.

Keep reference screenshots, downloaded skills, credentials, local plans and generated output out of Git. Follow [repository instructions](AGENTS.md), preserve dependency notices and retain the README's linked AI assistance credit. Record skills actually invoked in [development assistance](docs/DEVELOPMENT_TOOLS.md), including upstream, revision or access date, and purpose.

Contributions are expected under the project's existing [MIT](LICENSE-MIT) OR [Apache 2.0](LICENSE-APACHE) terms unless explicitly agreed otherwise.
