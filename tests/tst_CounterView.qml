import QtQuick
import QtTest
import org.zunobuilds.kdegui

Item {
    id: root
    width: 480
    height: 320

    Component {
        id: viewComponent
        CounterView { width: 200; height: 120 }
    }

    SignalSpy {
        id: valueSpy
        signalName: "valueChanged"
    }

    TestCase {
        name: "CounterView"
        when: windowShown

        function test_initialLabel() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let label = findChild(view, "counterLabel")
            verify(!!label, "Object exists")
            compare(view.value, 0)
            compare(label.text, qsTr("Count: %1").arg(0))
        }

        function test_clickUpdatesLabel() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            let label = findChild(view, "counterLabel")
            verify(!!label, "Object exists")
            mouseClick(button)
            tryCompare(label, "text", qsTr("Count: %1").arg(1))
        }

        function test_oneNotificationPerIncrement() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            valueSpy.target = view
            valueSpy.clear()
            for (let i = 1; i <= 3; ++i) {
                mouseClick(button)
                tryCompare(valueSpy, "count", i)
                tryCompare(view, "value", i)
            }
        }

        function test_instancesAreIndependent() {
            let first = createTemporaryObject(viewComponent, root)
            verify(!!first, "Component exists")
            let second = createTemporaryObject(viewComponent, root, { x: 220 })
            verify(!!second, "Component exists")
            let button = findChild(first, "incrementButton")
            verify(!!button, "Object exists")
            mouseClick(button)
            tryCompare(first, "value", 1)
            tryCompare(second, "value", 0)
        }

        function test_spaceActivatesButton() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            button.forceActiveFocus(Qt.TabFocusReason)
            tryCompare(button, "activeFocus", true)
            keyClick(Qt.Key_Space)
            tryCompare(view, "value", 1)
        }

        function test_tabTraversalBetweenInstances() {
            let first = createTemporaryObject(viewComponent, root)
            verify(!!first, "Component exists")
            let second = createTemporaryObject(viewComponent, root, { x: 220 })
            verify(!!second, "Component exists")
            let firstButton = findChild(first, "incrementButton")
            verify(!!firstButton, "Object exists")
            let secondButton = findChild(second, "incrementButton")
            verify(!!secondButton, "Object exists")
            firstButton.forceActiveFocus(Qt.TabFocusReason)
            tryCompare(firstButton, "activeFocus", true)
            keyClick(Qt.Key_Tab)
            tryCompare(secondButton, "activeFocus", true)
            keyClick(Qt.Key_Tab, Qt.ShiftModifier)
            tryCompare(firstButton, "activeFocus", true)
            keyClick(Qt.Key_Space)
            tryCompare(first, "value", 1)
            compare(second.value, 0)
        }

        function test_accessibleLabelTracksValue() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            let label = findChild(view, "counterLabel")
            verify(!!label, "Object exists")
            mouseClick(button)
            tryCompare(label.Accessible, "name", qsTr("Count: %1").arg(1))
        }
    }
}
