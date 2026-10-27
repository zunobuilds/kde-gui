# Installed skill provenance

Initial selection: `rust-best-practices` from Apollo GraphQL and `qt-qml` + `qt-qml-test` from Qt's upstream repository. The host installer only downloads these explicitly selected skill directories at fixed commit IDs after its host-side preflight. Source is **not** packed into the setup bundle.

The pinned versions, local SHA-256 inventories, source URLs, installation date and license references are written here by the installer and under `.work/telemetry/` when installation succeeds. Review future updates independently. Skills are *not* recorded as actually used merely because installed.

`qt-qml-review` is deferred because its shipped Python linter and other references still require a complete separate executable-code audit. `qt-qml-test-run` assumes CMake and is deferred during the Cargo-first prototype.

- `rust-best-practices`: [apollographql/skills](https://github.com/apollographql/skills), commit `5a62472a19f6d39abc727ffbe36e3dac7c747641`, license `MIT` (installed, **not used**).

- `qt-qml`: [TheQtCompanyRnD/agent-skills](https://github.com/TheQtCompanyRnD/agent-skills), commit `6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf`, license `BSD-3-Clause OR Qt-Commercial` (installed, **not used**).

- `qt-qml-test`: [TheQtCompanyRnD/agent-skills](https://github.com/TheQtCompanyRnD/agent-skills), commit `6845f02d41171a6df8b6e6fe225b7f5d1a6f4adf`, license `BSD-3-Clause OR Qt-Commercial` (installed, **not used**).
