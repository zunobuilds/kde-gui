# Appearance and accessibility

The experimental counter uses unmodified Qt Quick Controls and Kirigami spacing. Native Wayland rendering and several interactions have been observed; physical scaling changes and audible screen-reader acceptance remain **UNVERIFIED**.

## Automated evidence

On Fedora 44 with Qt 6.11.2, offscreen QML tests verify Space activation, Tab/Shift+Tab traversal, keyboard focus state, pressed/released states, cancelled clicks, disabled input, independent counters and layout bounds with larger fonts. Tests also run with the KDE desktop controls style and simulated scale factors. These checks exercise logical state and geometry; they do not establish visible focus contrast, physical display scaling or light/dark appearance.

The CTest accessibility executable queries Qt's accessibility interfaces. It verifies StaticText and Button roles, accessible names, button focusable/focused/disabled states, accessible press activation, count updates and announcement events. Count labels stay outside keyboard Tab traversal. Qt 6.11.2 still exposes static text as accessibility-focusable; this is [Qt behavior](https://github.com/qt/qtdeclarative/blob/v6.11.2/src/quick/accessible/qaccessiblequickitem.cpp), separate from Tab focus. The announcement API was introduced in [Qt 6.8](https://doc.qt.io/qt-6.8/qml-qtquick-accessible.html#announce-method).

## Native consumer evidence

Agent-operated probes loaded the separate consumer's unchanged `Main.qml` and installed module on Wayland with the software scene graph at the current display scale of 1.0. They used repository-local KDE configurations containing the installed Breeze Light and Breeze Dark color definitions; no host theme or display setting was changed. A separate consumer probe also rendered with default backend selection despite Mesa/EGL warnings; hardware acceleration remains **UNVERIFIED**.

- Both light and dark windows were exposed and rendered. Captures showed readable count text, visible keyboard focus, pressed and disabled control appearances.
- Both counters remained within the window at 260×200 and 800×500. Synthetic native Space, Tab and Shift+Tab events exercised independent increments and focus traversal. Return and keypad Enter each produced no increment with the observed KDE controls style; activation follows that style's behavior.
- Debugger-seeded native checks reached the integer maximum, automatically disabled the saturated button and traversed to the other counter. Its independent state remained zero. Light/dark captures showed the final count and disabled control.
- A uniquely named native probe exposed two count labels and buttons on AT-SPI, with enabled/focusable button states. An AT-SPI focus action also exposed the focused button state. AT-SPI press actions updated each counter independently, and the observer received exactly two `Count: 1` announcement events. A separate seeded native run delivered `Count: 2147483646` and `Count: 2147483647` over AT-SPI and exposed the saturated button as disabled while the other counter remained enabled. This used Qt's process-local `QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1` debug setting, not a desktop settings change.

These are agent-produced observations with controlled per-process colors and synthetic input. Desktop color-scheme switching, configured-font changes, physical 150%/200% scaling, hardware-keyboard interaction, GPU rendering and audible Orca output remain **UNVERIFIED**. Native probes do not establish arbitrary Plasma Global Theme support.

## Wayland diagnosis

The compositor socket is reachable and `wayland-info` succeeds in the development sandbox. A Qt-only probe, containing no library code, stalls during `QGuiApplication` construction. Its debugger trace shows KDE's platform theme waiting in `KConfig::isConfigWritable` for a warning process. This identifies a configuration-writability interaction before project QML loads, rather than evidence of a counter bug.

[KConfig 6.31 source](https://github.com/KDE/kconfig/blob/v6.31.0/src/core/ksharedconfig.cpp) supports `KDE_HOME_READONLY=1` to suppress the unwritable-configuration warning. Applied only to the test process, it allows the Qt-only probe to exit normally with the sandbox unchanged. It grants no filesystem access and changes no host settings.

The QML runner reported that its Wayland test window was neither active nor exposed, including with `QT_QUICK_BACKEND=software`; tests waiting for `windowShown` timed out. The separate consumer was subsequently exposed, rendered and became active. The retained timeout therefore describes the test-runner path, not a general native rendering failure. Its precise cause remains unresolved; identical runner retries were stopped.

`QSG_RHI_BACKEND=software` was an invalid test setting and has been replaced by `QT_QUICK_BACKEND=software`. Software scene-graph tests do not validate GPU rendering.

## Fedora desktop commands

Run from the repository root in a normal Fedora KDE terminal. Build and stage the module using [the build instructions](BUILDING.md), then build the separate consumer:

```sh
cmake -S smoke/qml-consumer -B build/qml-consumer -G Ninja
cmake --build build/qml-consumer
rpm -q plasma-workspace qt6-qtbase kf6-kirigami at-spi2-core orca
```

Launch with native Wayland and configured KDE fonts/style. Removing test rendering and scale overrides allows the desktop settings to apply. The command explicitly selects the installed KDE desktop controls style:

```sh
env -u QT_QUICK_BACKEND -u QSG_RHI_BACKEND -u QT_SCALE_FACTOR \
  -u KDE_HOME_READONLY \
  QML_IMPORT_PATH="$PWD/build/stage/lib/qt6/qml" \
  QT_QPA_PLATFORM=wayland QT_QUICK_CONTROLS_STYLE=org.kde.desktop \
  QT_FORCE_STDERR_LOGGING=1 \
  build/qml-consumer/kde_gui_qml_consumer "$PWD/smoke/qml-consumer/Main.qml" &
counter_pid=$!
```

For AT-SPI and speech checks, start the configured screen reader before launching the consumer. On the observed Fedora installation Orca is available:

```sh
orca --version
orca
```

If a screen reader is already running, use that instance. In another terminal, inspect the accessibility status:

```sh
gdbus call --session --dest org.a11y.Bus --object-path /org/a11y/bus \
  --method org.freedesktop.DBus.Properties.GetAll org.a11y.Status
```

The development session reported `IsEnabled=false` and `ScreenReaderEnabled=false`. Initial PID-only probes were inconclusive: AT-SPI reports a host PID while the sandbox reports a namespace PID. Matching a uniquely named native test process resolved discovery and allowed tree/action/announcement verification. Actual screen-reader speech remains **UNVERIFIED**; no desktop accessibility setting was changed.

From the terminal holding `counter_pid`, inspect only the consumer's tree and observe its announcements while activating both buttons:

```sh
timeout --kill-after=2s 40s python3 smoke/inspect-atspi.py "$counter_pid" --watch-seconds 30
```

The optional inspector requires Python GObject and the Atspi 2.0 typelib. It prints the target application's roles, names, enabled/focusable/focused states and `object:announcement` messages. It changes no settings and performs no button actions. Exit zero means observation ended, not that acceptance passed. Its native tree/event path was exercised successfully against a uniquely named test consumer. For namespace-sensitive diagnostics it also accepts `--application-name <unique-name>` instead of a PID; this requires an application name unique to that test process. Qt's [Linux accessibility bridge](https://github.com/qt/qtbase/blob/v6.11.2/src/gui/accessible/linux/qspiaccessiblebridge.cpp) maps count text to the AT-SPI label role and buttons to push-button roles; the [AT-SPI adaptor](https://github.com/qt/qtbase/blob/v6.11.2/src/gui/accessible/linux/atspiadaptor.cpp) forwards announcement events. This source mapping is not runtime proof.

The installed KDE settings modules can be opened from the normal terminal for the remaining desktop-settings checks:

```sh
kcmshell6 kcm_colors
kcmshell6 kcm_fonts
kcmshell6 kcm_kscreen
```

## Manual checklist

Record the package versions, selected color scheme, configured font, display scale and observed results:

- Launch under KDE light and dark color schemes. Inspect text contrast, native button surfaces and pressed, hovered, disabled and focused appearances. Record whether a restart is required after a setting change; live theme propagation is **UNVERIFIED**.
- Resize the two-counter window, including its smallest usable size. Check for clipped labels/buttons with the configured font and larger text. Repeat at 100%, 150% and 200% display scaling where available. Physical scaling and font rendering remain **UNVERIFIED**.
- Use Tab and Shift+Tab to reach both buttons; inspect visible focus. Use Space to increment each independently. Record Return and keypad Enter behavior under the selected native control style. Hardware-keyboard interaction remains **UNVERIFIED**; the native input evidence above used synthetic events.
- Inspect the AT-SPI tree with an accessibility inspector. Confirm count text, action names, roles, focus order and enabled/focused states. With a screen reader active, increment each counter and confirm that the corresponding updated count is announced once. Repeat keyboard traversal and activation without a mouse. Native AT-SPI exposure and event delivery have agent-produced evidence as described above; audible speech remains **UNVERIFIED**.

## Integer-limit evidence

The debugger-seeded integration check now verifies `2147483646` → `2147483647`, the final label and announcement, automatic button disabling, accessible disabled state, one notification per effective change and no notifications/announcements at saturation. GDB seeds private Rust state immediately before the first increment; the subsequent bridge, bindings and controls use unchanged production code. No public setter or alternate production initialization was added. The check passes 29 assertions; running its limit mode without debugger seeding fails as expected. See [the exact commands](BUILDING.md#integer-limit-integration-check).

The same seeded transition was also observed in light/dark native Wayland captures. Audible delivery of the final count remains **UNVERIFIED**. After preparing `build/limit-check` with [the debug build commands](BUILDING.md#integer-limit-integration-check), run the separate consumer under the same one-shot seed:

```sh
env -u QT_QUICK_BACKEND -u QSG_RHI_BACKEND -u QT_SCALE_FACTOR \
  -u KDE_HOME_READONLY QML_IMPORT_PATH="$PWD/build/limit-check/qml" \
  QT_QPA_PLATFORM=wayland QT_QUICK_CONTROLS_STYLE=org.kde.desktop \
  QT_FORCE_STDERR_LOGGING=1 \
  gdb -nx -q -x tests/counter-limit.gdb --args \
  build/qml-consumer/kde_gui_qml_consumer "$PWD/smoke/qml-consumer/Main.qml"
```

Activate the same counter twice: the first action displays `2147483646`; the second displays `2147483647` and disables that button. Inspect its light/dark disabled appearance, listen for each updated count, then Tab to the other counter and verify it still operates independently. Close the window to end the debugger run. The native transition has agent-produced visual evidence; repeat it with the configured screen reader to verify audible delivery.

## Limits

Reference screenshots provide layout guidance, not proof of runtime behavior. Arbitrary Plasma Global Theme support is **UNVERIFIED**. Automated results do not complete native acceptance.

Upstream guidance: [Kirigami documentation](https://develop.kde.org/frameworks/kirigami/).
