import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.zunobuilds.kdegui

ColumnLayout {
    id: root

    readonly property int value: state.value

    spacing: Kirigami.Units.smallSpacing

    CounterState {
        id: state
    }

    Label {
        id: counterLabel
        objectName: "counterLabel"
        text: qsTr("Count: %1").arg(root.value)
        Accessible.name: text
        onTextChanged: {
            if (root.value > 0)
                Accessible.announce(counterLabel.text, Accessible.Polite)
        }
    }

    Button {
        objectName: "incrementButton"
        text: qsTr("Increment")
        enabled: root.value < 2147483647
        onClicked: state.increment()
    }
}
