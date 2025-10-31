import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io

import qs

Button {
    id: root
    required property color defaultColor
    required property color hoverColor
    required property color borderColor
    required property color hoverBorderColor
    required property int bWidth
    required property int bHeight
    required property int borderWidth
    required property int iconHeight
    required property int textSize

    required property string title
    required property list<string> commands
    property string iconChar
    property bool isHovered

    background: Rectangle {
        color: root.isHovered ? root.hoverColor : root.defaultColor
        border.color: root.isHovered ? root.hoverBorderColor : root.borderColor
        implicitWidth: root.bWidth
        implicitHeight: root.bHeight
        border.width: root.borderWidth
        radius: height / 3
        RowLayout {
            anchors.centerIn: parent
            Text {
                text: root.iconChar + " "
                font.family: Config.iconFontFamily
                font.pixelSize: root.iconHeight
                color: Config.textColor
            }
            Text {
                text: root.title
                font.family: Config.textFontFamily
                font.pointSize: root.textSize
                color: Config.textColor
            }
        }
    }

    Process {
        id: process
        running: false
        command: root.commands
    }

    onClicked: {
        process.startDetached();
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onHoveredChanged: {
            root.isHovered = mouseArea.containsMouse;
        }

        onClicked: {
            process.startDetached();
        }
    }
}
