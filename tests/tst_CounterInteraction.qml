import QtQuick
import QtTest
import org.zunobuilds.kdegui

Item {
    id: root
    width: 640
    height: 480

    Component {
        id: viewComponent
        CounterView { width: 240; height: 160 }
    }

    TestCase {
        name: "CounterInteraction"
        when: windowShown

        function test_keyboardFocusAndPressedState() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            button.forceActiveFocus(Qt.TabFocusReason)
            tryCompare(button, "visualFocus", true)
            keyPress(Qt.Key_Space)
            tryCompare(button, "down", true)
            compare(view.value, 0)
            keyRelease(Qt.Key_Space)
            tryCompare(button, "down", false)
            tryCompare(view, "value", 1)
        }

        function test_cancelledPointerPressPreservesCount() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            mousePress(button)
            tryCompare(button, "down", true)
            mouseMove(button, -10, -10)
            mouseRelease(button, -10, -10)
            tryCompare(button, "down", false)
            tryCompare(view, "value", 0)
        }

        function test_disabledViewRejectsInput() {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            button.forceActiveFocus(Qt.TabFocusReason)
            view.enabled = false
            tryCompare(button, "enabled", false)
            keyClick(Qt.Key_Space)
            mouseClick(button)
            tryCompare(view, "value", 0)
            view.enabled = true
            mouseClick(button)
            tryCompare(view, "value", 1)
        }

        function test_resizeAndLargerFont_data() {
            return [
                { tag: "compact", pointSize: 12, extraWidth: 0 },
                { tag: "larger-font", pointSize: 24, extraWidth: 80 },
                { tag: "large-font", pointSize: 32, extraWidth: 160 }
            ]
        }

        function test_resizeAndLargerFont(data) {
            let view = createTemporaryObject(viewComponent, root)
            verify(!!view, "Component exists")
            let button = findChild(view, "incrementButton")
            verify(!!button, "Object exists")
            let label = findChild(view, "counterLabel")
            verify(!!label, "Object exists")
            button.font.pointSize = data.pointSize
            label.font.pointSize = data.pointSize
            tryVerify(() => view.implicitWidth >= Math.max(button.implicitWidth, label.implicitWidth))
            tryVerify(() => view.implicitHeight >= label.implicitHeight + button.implicitHeight + view.spacing)
            view.width = Math.ceil(view.implicitWidth) + data.extraWidth
            view.height = Math.ceil(view.implicitHeight)
            waitForPolish(view)
            verify(label.x >= 0 && label.y >= 0)
            verify(button.x >= 0 && button.y >= label.y + label.height)
            verify(label.x + label.width <= view.width)
            verify(button.x + button.width <= view.width)
            verify(button.y + button.height <= view.height)
            mouseClick(button)
            tryCompare(label, "text", qsTr("Count: %1").arg(1))
        }
    }
}
