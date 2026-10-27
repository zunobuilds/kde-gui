#include <QAccessible>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickItem>
#include <QQuickWindow>
#include <QSignalSpy>
#include <limits>
#include <cstdio>

static QString announcement;
static int announcementCount = 0;

static void recordAccessibilityEvent(QAccessibleEvent *event)
{
    if (event->type() == QAccessible::Announcement) {
        announcement = static_cast<QAccessibleAnnouncementEvent *>(event)->message();
        ++announcementCount;
    }
}

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    const bool limitTest = app.arguments().contains(QStringLiteral("--limit"));
    QAccessible::setActive(true);
    const auto previousHandler = QAccessible::installUpdateHandler(recordAccessibilityEvent);
    QQmlApplicationEngine engine;
    engine.loadData(R"(
        import QtQuick
        import org.zunobuilds.kdegui
        Window {
            visible: true
            width: 400
            height: 240
            CounterView { objectName: "view" }
        }
    )");
    if (engine.rootObjects().isEmpty())
        return 1;

    auto *window = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
    if (!window)
        return 1;
    auto *view = window->findChild<QQuickItem *>(QStringLiteral("view"));
    if (!view)
        return 1;
    auto *label = view->findChild<QQuickItem *>(QStringLiteral("counterLabel"));
    auto *button = view->findChild<QQuickItem *>(QStringLiteral("incrementButton"));
    auto *labelInterface = QAccessible::queryAccessibleInterface(label);
    auto *buttonInterface = QAccessible::queryAccessibleInterface(button);
    int failures = 0;
    const auto check = [&failures](bool passed, const char *name) {
        std::printf("%s: %s\n", passed ? "PASS" : "FAIL", name);
        if (!passed)
            ++failures;
    };
    check(labelInterface && labelInterface->role() == QAccessible::StaticText,
          "label exposes StaticText role");
    check(buttonInterface && buttonInterface->role() == QAccessible::Button,
          "button exposes Button role");
    if (!labelInterface || !buttonInterface)
        return 1;
    check(labelInterface->text(QAccessible::Name) == QStringLiteral("Count: 0"),
          "label exposes initial count");
    check(!label->activeFocusOnTab(), "count label stays outside keyboard Tab traversal");
    check(buttonInterface->text(QAccessible::Name) == QStringLiteral("Increment"),
          "button exposes action name");
    check(buttonInterface->state().focusable && !buttonInterface->state().disabled,
          "button exposes enabled and focusable states");
    check(announcementCount == 0, "initial construction does not announce a change");
    button->forceActiveFocus(Qt::TabFocusReason);
    check(buttonInterface->state().focused, "button exposes keyboard focus");
    auto *action = buttonInterface->actionInterface();
    check(action && action->actionNames().contains(QAccessibleActionInterface::pressAction()),
          "button exposes accessible press action");
    announcementCount = 0;
    QSignalSpy viewNotifications(view, SIGNAL(valueChanged()));
    check(viewNotifications.isValid(), "count notification spy is valid");
    if (action)
        action->doAction(QAccessibleActionInterface::pressAction());
    QCoreApplication::processEvents();
    // The debugger seeds only the first Rust increment in the optional limit test.
    const int firstValue = limitTest ? std::numeric_limits<int>::max() - 1 : 1;
    const auto firstText = QStringLiteral("Count: %1").arg(firstValue);
    check(view->property("value").toInt() == firstValue, "accessible press increments Rust state");
    check(viewNotifications.count() == 1, "increment emits one view notification");
    check(labelInterface->text(QAccessible::Name) == firstText,
          "accessible count updates after press");
    check(announcementCount == 1 && announcement == firstText,
          "increment emits one count announcement event");
    if (limitTest) {
        check(button->isEnabled(), "button remains enabled below the limit");
        QObject *state = nullptr;
        for (auto *child : view->children()) {
            if (child->metaObject()->indexOfMethod("increment()") >= 0) {
                check(!state, "view owns exactly one counter state");
                state = child;
            }
        }
        check(state, "counter state is available for saturation check");
        if (!state)
            return 1;
        QSignalSpy stateNotifications(state, SIGNAL(valueChanged()));
        check(stateNotifications.isValid(), "bridge notification spy is valid");
        action->doAction(QAccessibleActionInterface::pressAction());
        QCoreApplication::processEvents();
        const auto limitText = QStringLiteral("Count: %1").arg(std::numeric_limits<int>::max());
        check(view->property("value").toInt() == std::numeric_limits<int>::max(),
              "final effective action reaches the integer limit");
        check(labelInterface->text(QAccessible::Name) == limitText,
              "accessible label displays the integer limit");
        check(!button->isEnabled() && buttonInterface->state().disabled,
              "integer limit automatically disables the button and accessible state");
        check(stateNotifications.count() == 1 && viewNotifications.count() == 2,
              "limit transition emits one bridge and one view notification");
        check(announcementCount == 2 && announcement == limitText,
              "limit transition announces the final count once");
        check(QMetaObject::invokeMethod(state, "increment", Qt::DirectConnection),
              "bridge increment remains callable at saturation");
        action->doAction(QAccessibleActionInterface::pressAction());
        QCoreApplication::processEvents();
        check(view->property("value").toInt() == std::numeric_limits<int>::max(),
              "saturated bridge and disabled action preserve the value");
        check(stateNotifications.count() == 1 && viewNotifications.count() == 2,
              "saturation emits no additional bridge or view notification");
        check(announcementCount == 2, "saturation emits no additional announcement");
    }
    button->setEnabled(false);
    check(buttonInterface->state().disabled, "button exposes disabled state");
    if (action)
        action->doAction(QAccessibleActionInterface::pressAction());
    const int finalValue = limitTest ? std::numeric_limits<int>::max() : 1;
    check(view->property("value").toInt() == finalValue, "disabled accessible press preserves state");
    QAccessible::installUpdateHandler(previousHandler);
    return failures ? 1 : 0;
}
