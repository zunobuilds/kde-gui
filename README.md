# KDE GUI

A library experiment for native KDE applications, with a reusable Rust API and independently importable QML components.

**Status: experimental and source-only.** The counter API, CXX-Qt bridge and installed QML module have automated and controlled native checks on Fedora 44. The API and packaging layout may change. Physical scaling, desktop settings changes, hardware-keyboard interaction and audible screen-reader output remain unverified; see [appearance and accessibility](docs/THEME_SUPPORT.md).

## Current features

- A dependency-free Rust `Counter` with explicit saturation behavior.
- A read-only observable `CounterState` and a QML `CounterView` with a label and button.
- Qt Quick Controls and Kirigami spacing, independent instances and separate Rust/QML consumers.

Cargo builds the Rust library and bridge. A small CMake wrapper links and installs the QML plugin; a direct Cargo dynamic-library import failed during packaging tests.

## Quick start

The default Rust API requirements are Rust/Cargo with edition 2024 support and no Qt SDK. Rust/Cargo 1.99.0 was tested; a minimum supported toolchain has not been established. From a source checkout:

```sh
git clone https://github.com/zunobuilds/kde-gui.git
cd kde-gui
cargo test --locked
cargo run --manifest-path smoke/rust-consumer/Cargo.toml --locked
```

The tests should pass and the separate Rust consumer should print:

```text
Independent Rust consumer: count = 3
```

The crate is not published to a registry. To use the checkout from another Rust project, add a path dependency, replacing the example path with the checkout location:

```toml
[dependencies]
kde-gui = { path = "../kde-gui" }
```

```rust
use kde_gui::Counter;

fn main() {
    let mut counter = Counter::default();
    assert_eq!(counter.value(), 0);
    assert!(counter.increment());
    assert_eq!(counter.value(), 1);
}
```

`increment()` returns whether the value changed; it returns `false` at `i32::MAX`.

## QML usage

The QML plugin currently supports Linux only. It requires a C++17 compiler, CMake 3.24 or newer, Ninja, Qt 6.8 or newer with development tools, and Kirigami. Fedora 44 with Qt 6.11.2 and Kirigami 6.31.0 was tested; broader compatibility is unverified.

Follow [build and consumer instructions](docs/BUILDING.md#qml-module) to build, stage and expose the module through `QML_IMPORT_PATH`. Then use the component inside an application window:

```qml
import QtQuick
import org.zunobuilds.kdegui

CounterView { }
```

Each view owns an independent counter and displays its count with an increment button. The [separate QML demonstration](docs/BUILDING.md#separate-qml-demonstration) provides a complete two-counter Kirigami window; close it to exit.

## Roadmap

### Library foundation

- [x] Establish the experimental Rust API and QML components.
- [x] Verify both from separate applications.

### KDE integration

- [x] Verify local module installation and independent imports on Fedora.
- [x] Observe controlled light/dark rendering, synthetic keyboard input and accessibility events.
- [ ] Complete desktop settings, physical scaling, hardware-keyboard and audible screen-reader checks.

### Example application

- [ ] Build a small KDE showcase using the public API.
- [ ] Document setup and usage from a separate project.

## Documentation

[Documentation index](docs/README.md) · [Build instructions](docs/BUILDING.md) · [Technical overview](docs/ARCHITECTURE.md) · [Changelog](changelog/README.md)

## Contributing and help

Contributions of focused documentation, packaging research and API feedback are welcome. See [contribution guidelines](CONTRIBUTING.md) for setup, checks and review expectations. Use [GitHub issues](https://github.com/zunobuilds/kde-gui/issues) for reproducible bugs, usage questions and proposals. Remove secrets and personal data from reports and logs.

## Licensing

Dual-licensed under [MIT](LICENSE-MIT) **OR** [Apache 2.0](LICENSE-APACHE). Dependencies retain their own licences.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
