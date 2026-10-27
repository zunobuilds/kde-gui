# Technical overview

KDE GUI is planned as a reusable library for native KDE applications. The public interface has not been implemented yet.

## Stack

- **Rust** manages state and application-facing operations.
- **Qt 6 and QML/Kirigami** provide controls and presentation.
- **CXX-Qt** connects Rust state to Qt properties and actions.

## Library boundaries

The library will expose a Rust API and independently importable QML components. Separate consumer applications must demonstrate both interfaces.

Application-specific behavior belongs in each consumer. Example applications will demonstrate the public API without becoming dependencies of the library.

## Build and packaging

Cargo is the initial build entry point. Independent QML installation and import must be tested before deciding whether CMake is needed.

Supported versions, crate names, module identifiers and installation paths remain open. Initial native validation targets Fedora KDE.
