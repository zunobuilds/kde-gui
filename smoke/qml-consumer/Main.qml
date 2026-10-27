import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.zunobuilds.kdegui

Kirigami.ApplicationWindow {
    width: 420
    height: 260
    visible: true
    title: qsTr("KDE GUI counter")

    pageStack.initialPage: Kirigami.Page {
        title: qsTr("Independent counters")

        ColumnLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.largeSpacing

            CounterView { }
            CounterView { }
        }
    }
}
