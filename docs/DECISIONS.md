# Project decisions

## Agreed direction

- A reusable KDE library with Rust and independent QML interfaces.
- Rust, Qt 6, QML/Kirigami and CXX-Qt for the first prototype.
- Cargo-first builds; CMake is limited to QML plugin linking and installation after a direct Cargo plugin import failed.
- Separate consumer applications to verify library reuse.
- Application-specific logic stays outside the library.

## Open questions

- Minimum Rust, compiler, Qt and Kirigami versions.
- Stable public API and release naming.
- Distribution packaging and supported installation layout beyond the Linux experiment.

## Experimental implementation choices

- Crate: `kde-gui` 0.1.0; Rust import: `kde_gui`.
- Rust API: `Counter::default()`, `value()` and `increment()`.
- QML module: `org.zunobuilds.kdegui`; types: `CounterState` and `CounterView`.
- State: initially zero, saturating at `i32::MAX`, one notification per effective bridge change.
- Ownership: each view owns its state; no shared singleton or asynchronous layer.
- Dependencies: CXX-Qt 0.10.0 and CXX 1.0.205, with transitive versions recorded in `Cargo.lock`. No `cxx-qt-lib` dependency is needed for the integer-only bridge.
- Packaging: a CMake Qt plugin wrapper around the Cargo static archive. The [technical overview](ARCHITECTURE.md#build-and-packaging) records the failed direct dynamic-plugin import that justified this addition.

These identifiers and the installed layout are experimental. The [build instructions](BUILDING.md) record tested tool versions without claiming a minimum supported platform matrix.

## Example direction

A small task-list app is the proposed showcase. Adding, editing and completing items would exercise list models, text input, actions, empty states and keyboard navigation.

A calculator remains useful for basic button input and state changes, but covers fewer interface patterns. The showcase choice is still open; no example implementation is included.

## Licensing

Original project code and documentation use **MIT OR Apache-2.0**. Contributions are expected under the same dual licence unless explicitly agreed otherwise.

### Rationale

- Permissive terms support broad reuse, including commercial applications.
- The Apache option includes explicit contributor patent terms.
- The same licensing approach is used by Rust and CXX-Qt.

This prioritizes reuse over requiring downstream modifications to be published. The full terms are in [LICENSE-MIT](../LICENSE-MIT) and [LICENSE-APACHE](../LICENSE-APACHE).

### Dependency obligations

Qt, Kirigami and other dependencies retain their own licences. Selected modules, versions, linking and redistribution requirements must be reviewed before release.

### Research references

Checked 27 October 2026:

- [MIT terms](https://opensource.org/license/mit) and [Apache 2.0 terms](https://www.apache.org/licenses/LICENSE-2.0): permissions, notices and patent provisions.
- [Rust licensing](https://rustc-dev-guide.rust-lang.org/licenses.html) and [CXX-Qt manifest](https://github.com/KDAB/cxx-qt/blob/3c288df83135c9986757fe65953e3fa2c7b10dec/Cargo.toml): ecosystem precedent.
- [Qt licensing](https://doc.qt.io/qt-6/licensing.html) and an inspected [Kirigami file header](https://github.com/KDE/kirigami/blob/116ef3cb69856d708c2821cc14e4654c041f99a8/src/controls/Action.qml): dependency terms, not a complete dependency audit.
- [SPDX MIT text](https://github.com/spdx/license-list-data/blob/31ba1a50e5397e00a304dbadc76531740e89ee48/text/MIT.txt) and [Apache text](https://www.apache.org/licenses/LICENSE-2.0.txt): sources for the repository licence files.
