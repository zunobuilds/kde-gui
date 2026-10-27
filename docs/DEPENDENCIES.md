# Dependencies and licences

Inventory reviewed on 27 October 2026 against resolved Cargo manifests, downloaded source licence headers and Fedora package metadata. This records the experimental dependency selection; it is not a completed binary-redistribution audit.

## Direct dependencies

| Dependency | Version | Purpose | Declared licence |
| --- | --- | --- | --- |
| CXX | 1.0.205 | C++/Rust bridge support, optional `qt` feature | MIT OR Apache-2.0 |
| CXX-Qt | 0.10.0 | QObject generation and bridge support, optional `qt` feature | MIT OR Apache-2.0 |
| cxx-qt-build | 0.10.0 | Build-time generation, Qt discovery and registration | MIT OR Apache-2.0 |

The default Rust API uses only the standard library. `cxx-qt-lib` is unnecessary for the integer-only bridge. Direct crate versions are pinned; `Cargo.lock` records transitive resolution. CXX-Qt declares Rust 1.85.0 as its minimum; only Rust 1.99.0 was exercised here.

Primary references: [CXX-Qt 0.10.0 source](https://github.com/KDAB/cxx-qt/tree/v0.10.0), [CXX source](https://github.com/dtolnay/cxx), [CXX-Qt builder](https://docs.rs/cxx-qt-build/0.10.0/cxx_qt_build/struct.CxxQtBuilder.html). No upstream application implementation was copied.

## Qt and KDE runtime

The observed Fedora SDK uses Qt 6.11.2 and Kirigami 6.31.0. The plugin dynamically links Qt; the QML view imports Qt Quick Controls, Layouts and Kirigami. The consumer uses Qt Gui/QML and a Kirigami application window. KDE desktop control styling remains a system runtime choice.

Fedora identifies Qt Base and Declarative under `LGPL-3.0-only OR GPL-3.0-only WITH Qt-GPL-exception-1.0`. Its Kirigami and desktop-style packages contain multiple LGPL, GPL, BSD, MIT and other licence expressions across different files and assets; package-level expressions do not identify the licence of every linked or loaded component. These dependencies are not relicensed under the project grant.

System dependency licence texts remain in the installed distribution packages. Before distributing a binary bundle, review the exact Qt/KDE modules and assets, linking arrangement, notices and applicable source/relinking requirements. The local module staging proof does not establish those release obligations. Upstream references: [Qt licensing](https://doc.qt.io/qt-6/licensing.html) and [Kirigami source and licence files](https://invent.kde.org/frameworks/kirigami).

## Resolved Rust inventory

The table includes build tools, procedural macros and platform-conditional dependencies as resolved with all features. These are manifest licence expressions, not a claim that every listed crate is linked into the installed plugin. Standard-library and compiler/runtime licensing is separate. Upstream licence files remain in the fetched crates; retain their notices when redistributing applicable code or binaries.

| Crate | Version | Declared licence |
| --- | --- | --- |
| `anyhow` | 1.0.104 | MIT OR Apache-2.0 |
| `cc` | 1.10.0 | MIT OR Apache-2.0 |
| `cfg-if` | 1.0.5 | MIT OR Apache-2.0 |
| `clang-format` | 0.3.0 | MIT OR Apache-2.0 |
| `codespan-reporting` | 0.11.1 | Apache-2.0 |
| `codespan-reporting` | 0.13.1 | Apache-2.0 |
| `convert_case` | 0.6.0 | MIT |
| `cxx` | 1.0.205 | MIT OR Apache-2.0 |
| `cxx-build` | 1.0.205 | MIT OR Apache-2.0 |
| `cxx-gen` | 0.7.205 | MIT OR Apache-2.0 |
| `cxx-qt` | 0.10.0 | MIT OR Apache-2.0 |
| `cxx-qt-build` | 0.10.0 | MIT OR Apache-2.0 |
| `cxx-qt-gen` | 0.10.0 | MIT OR Apache-2.0 |
| `cxx-qt-macro` | 0.10.0 | MIT OR Apache-2.0 |
| `cxxbridge-flags` | 1.0.205 | MIT OR Apache-2.0 |
| `cxxbridge-macro` | 1.0.205 | MIT OR Apache-2.0 |
| `equivalent` | 1.0.3 | Apache-2.0 OR MIT |
| `find-msvc-tools` | 0.1.15 | MIT OR Apache-2.0 |
| `foldhash` | 0.2.0 | Zlib |
| `getrandom` | 0.4.3 | MIT OR Apache-2.0 |
| `hashbrown` | 0.17.1 | MIT OR Apache-2.0 |
| `indexmap` | 2.14.2 | Apache-2.0 OR MIT |
| `indoc` | 2.0.8 | MIT OR Apache-2.0 |
| `itoa` | 1.0.18 | MIT OR Apache-2.0 |
| `jobserver` | 0.1.35 | MIT OR Apache-2.0 |
| `libc` | 0.2.191 | MIT OR Apache-2.0 |
| `link-cplusplus` | 1.0.12 | MIT OR Apache-2.0 |
| `memchr` | 2.8.3 | Unlicense OR MIT |
| `proc-macro2` | 1.0.107 | MIT OR Apache-2.0 |
| `qt-build-utils` | 0.10.0 | MIT OR Apache-2.0 |
| `quote` | 1.0.47 | MIT OR Apache-2.0 |
| `r-efi` | 6.0.0 | MIT OR Apache-2.0 OR LGPL-2.1-or-later |
| `rustversion` | 1.0.23 | MIT OR Apache-2.0 |
| `scratch` | 1.0.9 | MIT OR Apache-2.0 |
| `semver` | 1.0.28 | MIT OR Apache-2.0 |
| `serde` | 1.0.229 | MIT OR Apache-2.0 |
| `serde_core` | 1.0.229 | MIT OR Apache-2.0 |
| `serde_derive` | 1.0.229 | MIT OR Apache-2.0 |
| `serde_json` | 1.0.154 | MIT OR Apache-2.0 |
| `shlex` | 2.0.1 | MIT OR Apache-2.0 |
| `static_assertions` | 1.1.0 | MIT OR Apache-2.0 |
| `syn` | 2.0.119 | MIT OR Apache-2.0 |
| `syn` | 3.0.9 | MIT OR Apache-2.0 |
| `termcolor` | 1.4.1 | Unlicense OR MIT |
| `thiserror` | 1.0.69 | MIT OR Apache-2.0 |
| `thiserror-impl` | 1.0.69 | MIT OR Apache-2.0 |
| `unicode-ident` | 1.0.27 | (MIT OR Apache-2.0) AND Unicode-3.0 |
| `unicode-segmentation` | 1.13.3 | MIT OR Apache-2.0 |
| `unicode-width` | 0.1.14 | MIT OR Apache-2.0 |
| `unicode-width` | 0.2.2 | MIT OR Apache-2.0 |
| `which` | 8.0.6 | MIT |
| `winapi-util` | 0.1.11 | Unlicense OR MIT |
| `windows-link` | 0.2.1 | MIT OR Apache-2.0 |
| `windows-sys` | 0.61.2 | MIT OR Apache-2.0 |
| `zmij` | 1.0.23 | MIT |
