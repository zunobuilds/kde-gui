# KDE GUI

An independent, greenfield KDE-oriented GUI library planned for Rust and Qt 6/QML consumers.

**Status: planning only.** There is no library implementation, Cargo manifest, supported public API, release or selected project licence. The technical direction below is planned, not a claim of working integration.

## Purpose and planned features

Provide a reusable Rust API and independently importable QML components that follow native KDE appearance. The first milestone, **K-001**, is a small label/counter proving state updates, keyboard operation, accessibility and downstream use. A calculator follows only after that proof passes.

KDE GUI, future GNOME GUI and future Unified GUI remain three independent greenfield libraries. No shared fourth repository or cross-toolkit runtime switching is required here.

## Architecture

The first prototype will use **Rust + Qt 6 + QML/Kirigami + CXX-Qt**, with Cargo as the initial build entry point. Rust owns counter state; a narrow bridge exposes observable state and actions to QML. QML owns presentation and uses native controls. Exact API names, crate name, module URI and versions remain open.

Separate downstream Rust and QML consumers must demonstrate reuse without importing private source files or relying on the in-crate demo. CMake will be considered only if real QML installation/import experiments show it is necessary. See [architecture](docs/ARCHITECTURE.md), [decisions](docs/DECISIONS.md) and the [K-001 plan](docs/K-001.md).

## Repository layout

| Path | Responsibility |
| --- | --- |
| `docs/` | Architecture, decisions, planning, development evidence and limitations |
| `tools/check_docs.py` | Dependency-free documentation checks |
| `references/kde-system-apps/` | Local screenshot intake and provenance; entire intake excluded from Git |
| `src/`, `qml/` | Reserved for the Rust library and QML components after approval |
| `examples/` | Reserved for consumer examples; calculator logic belongs here |
| `tests/`, `smoke/` | Reserved for focused tests and independent consumer proofs |

Reserved empty directories do not appear in Git clones. They will be added with substantive files, without marker files. Local development telemetry, supervisors, downloaded skills and caches are also excluded. The [organization audit](docs/REPOSITORY_AUDIT.md) explains the boundaries.

## Requirements and developer usage

Reading and editing these documents requires no Qt installation. The planned implementation requires Rust/Cargo, a compatible C++ toolchain, Qt 6 development and runtime modules, Kirigami and CXX-Qt. Minimum versions, dependency licences and distribution requirements must be reviewed before implementation. Native behavior must be verified on Fedora KDE; other platforms are unverified.

Start with [decisions](docs/DECISIONS.md), [K-001](docs/K-001.md) and [theme support](docs/THEME_SUPPORT.md). Native Fedora confinement remains unverified; the historical operator checklist is retained locally and is not included in clones.

For documentation work, clone this private repository using an authorized GitHub account, then run the checks from its root with Python 3 and Git:

```sh
git clone https://github.com/zunobuilds/kde-gui.git
cd kde-gui
python3 tools/check_docs.py
git diff --check
```

There are currently **no build, run, install or test commands for a library**. Do not run Cargo expecting a working project. K-001 will add reproducible commands only after the dependency and packaging experiment establishes them.

## Tests and acceptance

The documentation check validates relative links and heading anchors, the required AI credit, README coverage and the absence of README images. It does not validate external URL availability. No Rust, QML, native theme or accessibility tests have run. K-001 requires state and notification tests, keyboard and assistive-technology checks, light/dark and scaling checks, and independent Rust/QML consumer builds and execution. Headless tests alone cannot establish native appearance or screen-reader behavior. See the [acceptance matrix](docs/K-001.md#acceptance-tests).

## Roadmap

1. Approve K-001 scope; verify Fedora containment and review dependencies, licences and toolchain compatibility.
2. Prove the Cargo-first counter, including standalone Rust and installed QML consumption.
3. Record observed native behavior and supported packaging; decide whether CMake is warranted.
4. Build a calculator example with digits, decimal, arithmetic, equals, clear and safe invalid-input/zero-division handling. Keep math and state in the example.
5. Compare high-level calculator usage with separately developed GNOME and Unified libraries without coupling repositories or promising identical toolkit APIs.

## Contributions

Keep changes bounded and discuss API, dependency and packaging choices before implementation. Include the problem, relevant decision, validation performed and remaining uncertainty in proposed changes. Preserve existing provenance and local tooling. Never commit credentials, local screenshots, downloaded skills, caches or telemetry. No contribution automation or CI is configured yet.

## Limitations and licensing

Native theme interactions, external QML installation, supported versions and accessibility are unverified. Local screenshots demonstrate observed layouts only and confer no redistribution rights. Arbitrary Plasma Global Theme portability and instant in-window GTK/Qt swapping are not promised.

The project licence is **undecided**; no open-source licence grant is currently provided. Review project licensing and every dependency's build, runtime and redistribution obligations before reuse or release. Upstream research repositories retain their own licences; no content or assets are copied into this project.

[Developed with the help of OpenAI Codex and cloud AI models.](docs/DEVELOPMENT_TOOLS.md)
