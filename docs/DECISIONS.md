# Decisions and outstanding items

- **ACCEPTED / PLANNED:** KDE P01-P10 (2026-10-25); independent, greenfield KDE-first; Rust/Qt6/QML/Kirigami/CXX-Qt first prototype, Cargo-first; separate Rust and QML importability tests; K-001 before calculator.
- **ACCEPTED / PLANNED:** one independent `kde-gui` repository. GNOME and Unified remain equally first-class but are later, separate projects.
- **PLANNED:** future cross-repository calculator parity, with math/state in examples. Screenshots are local design references, not library assets.
- **ACCEPTED — 2026-10-27:** project-owned code and documentation use `MIT OR Apache-2.0`, at the recipient's option; see [MIT](../LICENSE-MIT) and [Apache 2.0](../LICENSE-APACHE).
- **OPEN:** final project/release name, crate name, QML URI, minimum toolchain versions, packaging, external publishing, exact API.
- **UNVERIFIED:** Qt build, GNOME/Unified compatibility, native UI behavior and installed toolchain/runtime availability on Fedora.

The 2026-10-25 previous bundle is historical. Do not reuse former project code, scripts or licence choices.

Local launcher, sandbox and publication-policy records are retained in ignored development records. They do not change the library decisions above or establish native runtime validation.

## Licensing

The choice prioritizes broad reuse of an independent GUI library. Users can select either licence; they do not have to satisfy both. The [MIT terms](https://opensource.org/license/mit) permit modification, redistribution and commercial use while requiring preservation of the copyright and permission notice. The [Apache 2.0 terms](https://www.apache.org/licenses/LICENSE-2.0) offer an explicit contributor patent grant with defined scope and termination provisions. Neither option requires downstream users to publish changes to this project's code.

This follows the approach used by [Rust's compiler and standard library](https://rustc-dev-guide.rust-lang.org/licenses.html) and the planned [CXX-Qt bridge](https://github.com/KDAB/cxx-qt/blob/3c288df83135c9986757fe65953e3fa2c7b10dec/Cargo.toml). It fits the project's reusable Rust/QML API goal without selecting licences for the independent GNOME or Unified projects. Future Cargo metadata should use the SPDX expression `MIT OR Apache-2.0`; no Cargo manifest is introduced during planning.

The grant covers original project-owned source and documentation, with third-party material retaining its own terms. Contributions intentionally submitted for inclusion are expected under the same dual licence unless explicitly agreed otherwise. Local screenshots and downloaded skills are excluded; their provenance and redistribution restrictions remain intact.

This does not relicense Qt or Kirigami. [Qt's licensing documentation](https://doc.qt.io/qt-6/licensing.html) describes LGPL/commercial options and some GPL-only modules. The inspected [Kirigami Action header](https://github.com/KDE/kirigami/blob/116ef3cb69856d708c2821cc14e4654c041f99a8/src/controls/Action.qml) identifies `LGPL-2.0-or-later`; this is a file-level observation, not an audit of the entire framework. Exact dependency versions, selected modules, linking, QML deployment, notices and source/relinking obligations still require review before distribution.

Sources checked 2026-10-27. Standard licence texts come from the [SPDX MIT text](https://github.com/spdx/license-list-data/blob/31ba1a50e5397e00a304dbadc76531740e89ee48/text/MIT.txt) and the [Apache Software Foundation](https://www.apache.org/licenses/LICENSE-2.0.txt). The MIT copyright line identifies `2026 zunobuilds and contributors`; the Apache text is unchanged, including its standard illustrative appendix.
