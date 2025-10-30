import QtQuick
import QtQuick.Controls

import qs

Button {
    id: root
    required property string iconString
    required property color iconColor
    required property var clickAction
    property var doubleClickAction: function () {}
    property string fontFamily: Theme.iconFontFamily
    property int fontSize: Theme.iconHeight

    background: Rectangle {
        id: rect
        color: "transparent"
        implicitHeight: root.fontSize
        implicitWidth: root.fontSize

        Text {
            anchors.centerIn: rect
            text: root.iconString
            color: root.iconColor
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onClicked: root.clickAction()
        onDoubleClicked: root.doubleClickAction()
    }
}
