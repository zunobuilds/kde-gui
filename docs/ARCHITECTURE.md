# Technical overview

KDE GUI provides an experimental Rust counter and a separately importable Qt 6 QML module. The initial implementation targets Linux on Fedora; the API and packaging layout are not stable.

## State and ownership

`kde_gui::Counter` is ordinary Rust state with no default dependencies. It starts at zero, increments by one and saturates at `i32::MAX`. `increment()` returns whether the value changed. Each instance owns its value.

The optional `qt` feature adds a CXX-Qt QObject named `CounterState`, registered in `org.zunobuilds.kdegui`. It owns one Rust `Counter`, exposes a read-only integer `value`, and provides `increment()`. It emits `valueChanged` once after an effective increment and emits nothing at saturation. The bridge reads the Rust state directly rather than maintaining a second value.

`CounterView` owns a `CounterState` as a QML child object. Destruction of the view destroys its state. Views cannot inject or share state in this initial API; consumers needing separate presentation can instantiate `CounterState` directly. QML engine ownership and synchronous GUI-thread actions apply. No worker thread or singleton is required.

## Presentation

`CounterView` uses a Qt Quick Controls `Label` and `Button`, with Kirigami semantic spacing. Control styling, fonts and colors come from Qt/KDE configuration. The increment button disables at the integer limit. User-visible strings use QML translation functions. Changed count text requests a polite accessibility announcement through Qt; initial construction does not announce a change. Audible delivery depends on the desktop accessibility bridge and screen reader and remains **UNVERIFIED**.

Application windows and application-specific behavior belong to consumers. `smoke/qml-consumer` provides a separately built engine and a Kirigami window containing two independent counters.

## Build and packaging

Cargo builds the Rust API and generates the bridge, registration metadata, QML resources and static archive using CXX-Qt 0.10.0. CMake adds a small native `QQmlEngineExtensionPlugin` wrapper, links the archive and installs the module descriptor, type information, QML file and shared library together.

The CMake wrapper follows an observed packaging failure: a Cargo `cdylib` built with a CXX-Qt dynamic plugin could not be imported by an independent engine, which reported `Could not resolve 'qt_plugin_instance' function`. Switching from GNU BFD to LLVM LLD corrected dynamic Qt dependencies but did not export the plugin entry point. The native wrapper supplies the Qt plugin ABI and references the generated CXX-Qt initializer. This initializer is an experimental dependency on the pinned CXX-Qt release.

The installed module is imported by URI through a QML import root. It does not require Rust-linked application code, a context property or source-directory imports. The separate Rust consumer also runs against an extracted Cargo package. See [build instructions](BUILDING.md) and the [dependency inventory](DEPENDENCIES.md).
