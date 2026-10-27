# Architecture (planned)

The KDE library will expose a reusable Rust facade and a standalone importable QML component layer. Initial prototype: Rust + Qt 6 + QML/Kirigami + CXX-Qt, built Cargo-first; CMake is an optional later aid only if independent QML installation/import requires it.

The K-001 counter is the first integration proof; the calculator follows after separate external Rust and QML consumer imports and native KDE theming/accessibility validation. Calculator logic stays in the example consumer. No implementation, module identifier or public API is selected or tested yet.

The future GNOME and Unified GUI repos are independent projects; unified consumes independently versioned, tested-compatible KDE/GNOME libraries and preserves application state across a supported frontend switch or reinitialization. Seamless instantaneous native toolkit hot-swapping is unverified.
