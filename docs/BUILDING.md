# Building and using the counter

The prototype is tested on Fedora 44 with Rust/Cargo 1.99.0, GCC C++ 16.2.1, Qt 6.11.2 and Kirigami 6.31.0. These are observed versions, not a minimum-supported-version promise. The QML installation wrapper currently supports Linux only.

## Rust foundation

From the repository root:

```sh
export CARGO_HOME="$PWD/.work/implementation/cargo-home"
cargo test --locked
cargo run --manifest-path smoke/rust-consumer/Cargo.toml --locked
```

The default library has no dependencies and requires no Qt SDK. `Counter::default()` starts at zero; `increment()` returns `false` at `i32::MAX` without changing the value. The consumer is a standalone Cargo project using the public `kde_gui::Counter` API.

## QML module

Build requirements are a C++17 compiler, Cargo, CMake 3.24 or newer, Ninja, Qt Core/QML/Quick/QuickControls2 development files and Qt's QML registration tools. Kirigami and Qt Quick Controls must be installed for runtime use. Automated QML tests require Qt Quick Test's runner (`qmltestrunner-qt6` on Fedora).

```sh
cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="$PWD/build/stage" \
  -DKDE_GUI_QML_INSTALL_DIR=lib/qt6/qml
cmake --build build
ctest --test-dir build --output-on-failure
cmake --install build
export QML_IMPORT_PATH="$PWD/build/stage/lib/qt6/qml"
export QT_FORCE_STDERR_LOGGING=1
```

The CMake target calls `cargo build --release --features qt --locked`, then links the native plugin wrapper. `KDE_GUI_QML_INSTALL_DIR` controls the import-root location relative to the installation prefix; its default uses CMake's platform library directory. The import root must contain `org/zunobuilds/kdegui`, rather than pointing directly at that module directory.

The staged module contains `qmldir`, `plugin.qmltypes`, `qml/CounterView.qml` and `liborg_zunobuilds_kdegui.so`. It uses system Qt/Kirigami libraries. Redistributed binaries need their own dependency and notice review; see [dependencies](DEPENDENCIES.md).

## Separate QML demonstration

```sh
cmake -S smoke/qml-consumer -B build/qml-consumer -G Ninja
cmake --build build/qml-consumer
build/qml-consumer/kde_gui_qml_consumer "$PWD/smoke/qml-consumer/Main.qml"
```

This engine links only Qt Gui/QML and imports the installed library by URI. It registers no project types or context properties. The window contains two independent counters. A native desktop session is needed for visual inspection.

For a headless load check, add `--check` and use `QT_QPA_PLATFORM=offscreen QSG_RHI_BACKEND=software`. This checks window construction and import, then exits; it does not perform visual acceptance.

## Independent package checks

Run from the repository root after staging the QML module:

```sh
bash smoke/check-packaged-consumers.sh "$QML_IMPORT_PATH"
```

The check extracts the Cargo package, copies consumer/test sources and relocates the installed module into a fresh directory under `target/`. It builds and runs both consumers there, then runs the QML interaction tests. Its import root contains the relocated module; neither consumer nor tests import the original library source directory. The Rust consumer points to the extracted package, outside the original Cargo root.

`--allow-dirty` permits local package verification before a commit; no package is published. `--offline` requires prior dependency fetching with `cargo fetch --locked`. Explicit package inclusion patterns exclude reference screenshots, operational records, local tools and build outputs.

## Additional checks and tool issues

```sh
cargo fmt --all -- --check
QMAKE=/usr/bin/qmake6 cargo test --all-features --locked
QMAKE=/usr/bin/qmake6 cargo clippy --all-targets --all-features --locked -- -D warnings
qmllint-qt6 -I "$QML_IMPORT_PATH" --max-warnings 0 \
  qml/CounterView.qml smoke/qml-consumer/Main.qml \
  tests/tst_CounterView.qml tests/tst_CounterState.qml
```

Use the actual qmake path for other distributions. Cargo Qt executables and tests require a linker supported by CXX-Qt; LLVM LLD was used for the observed all-feature checks. CXX-Qt's warning about GNU BFD should not be treated as a passed link check.

Fedora's initial Rust installation lacked Rustfmt and Clippy. The observed checks used matching Fedora 1.99.0 RPM payloads extracted into an ignored repository-local tool directory, with their signatures checked. LLD also ran from a local RPM payload with its matching libraries. No operating-system packages were installed. Contributors can use provisioned tools on `PATH`; local payloads are not distributed by this project.

Cargo dependency fetching succeeded in the sandbox. Missing offline crates were resolved with `cargo fetch --locked`; no alternate registry or network bypass was needed. Fedora Qt messages required `QT_FORCE_STDERR_LOGGING=1` for readable terminal diagnostics.

## Validation limits

State tests cover initialization, repeated increments, integer saturation and independent instances. QML tests cover read-only bridge state, notifications, label updates, accessible label text, clicks, Space activation and Tab/Shift+Tab traversal. The QML runner reports 13 passes, including four setup/teardown cases; nine are behavior tests.

Native light/dark appearance, configured fonts, scale factors, visible focus, platform-specific Return/Enter behavior, accessibility-tree inspection and actual screen-reader announcements remain unverified. Automated offscreen results do not complete native acceptance.
