import QtQuick
import QtQuick.Layouts

import qs

Rectangle {
    id: root

    property Item content
    property color bgColor
    property color hoverColor
    property color borderColor
    property var onClicked
    property var onHovered: function () {}

    Layout.preferredWidth: content.implicitWidth + Config.componentPadding
    Layout.preferredHeight: Config.componentHeight
    radius: Config.componentHeight / 3
    color: mouseArea.containsMouse ? root.hoverColor : root.bgColor
    border.color: borderColor
    border.width: Config.componentBorderSize

    Behavior on color {
        ColorAnimation {
            duration: Config.componentHoverAnimationDuration
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        hoverEnabled: true
        cursorShape: root.onClicked ? Qt.PointingHandCursor : Qt.ArrowCursor
        acceptedButtons: Qt.LeftButton

        onClicked: {
            if (root.onClicked && typeof root.onClicked === "function") {
                root.onClicked();
            }
        }

        onHoveredChanged: {
            if (root.onHovered && typeof root.onHovered === "function") {
                root.onHovered();
            }
        }
    }

    Item {
        id: contentContainer
        implicitWidth: root.content.implicitWidth
        implicitHeight: root.content.implicitHeight
        anchors.centerIn: parent
        children: [root.content]
    }
}
