# Appearance and accessibility

Native behavior is a project goal. The experimental counter uses unmodified Qt Quick Controls and Kirigami spacing. Its native appearance has not been visually accepted on a KDE desktop.

## Automated evidence

On Fedora 44 with Qt 6.11.2, offscreen tests verify Space activation, Tab/Shift+Tab traversal between two counters, label binding updates and the label's accessible name following its value. These checks do not inspect the platform accessibility tree or establish screen-reader announcements, visible focus or native theme behavior.

## Appearance goals

- Use native Qt/Kirigami controls and semantic theme colors.
- Respect configured fonts, spacing and scaling.
- Keep focus, disabled and pressed states visible.

## Validation

Initial checks will run on Fedora KDE and cover:

- Light and dark appearance, font changes and display scaling.
- Keyboard navigation, activation and visible focus.
- Accessible names, roles and state changes with assistive technology.

## Limits

Reference screenshots provide layout guidance, not proof of runtime behavior. Arbitrary Plasma Global Theme support is unverified.

Upstream guidance: [Kirigami documentation](https://develop.kde.org/frameworks/kirigami/).
