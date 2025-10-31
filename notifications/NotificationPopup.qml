pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Widgets
import Quickshell

import qs
import qs.services
import qs.widgets

Rectangle {
    id: root

    property bool onlyVisible: true
    required property Notifications.Notif modelData

    Component.onCompleted: {
        root.modelData.dismiss = () => {
            root.dismiss();
        };

        root.modelData.hideNotif = () => {
            root.hide();
        };

        if (!onlyVisible)
            root.modelData.visible = false;

        appearAnimation.running = true;
    }
    // initially offscreen and invisible
    x: width
    opacity: 0

    width: Config.notificationWidth
    color: Config.osdSliderBackground
    radius: Config.notificationHeight / 3
    border.color: {
        switch (modelData.urgency || NotificationUrgency.Low) {
        case NotificationUrgency.Critical:
            return Config.notificationBorderUrgent;
        case NotificationUrgency.Normal:
            return Config.notificationBorderNormal;
        case NotificationUrgency.Low:
            return Config.notificationBorderLow;
        }
    }
    border.width: Config.notificationBorderWidth

    height: contentRow.height + Config.notificationPadding

    ParallelAnimation {
        id: appearAnimation
        running: false

        NumberAnimation {
            target: root
            to: 0
            property: "x"
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            to: 1
            property: "opacity"
            duration: 200
            easing.type: Easing.BezierSpline
        }
    }

    ParallelAnimation {
        id: discardAnimation
        running: false
        property var doAfter: () => {}

        NumberAnimation {
            target: root
            to: root.width
            property: "x"
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            to: 0
            property: "opacity"
            duration: 200
            easing.type: Easing.BezierSpline
        }
        onFinished: () => {
            doAfter();
        }
    }

    function dismiss() {
        discardAnimation.doAfter = () => {
            root.modelData.notification.dismiss();
        };
        discardAnimation.running = true;
    }

    function hide() {
        if (!root.onlyVisible)
            return;
        discardAnimation.doAfter = () => {
            root.modelData.visible = false;
        };
        discardAnimation.running = true;
    }

    ClickableIcon {
        id: silentButton
        visible: root.onlyVisible && root.modelData.visible

        anchors {
            top: root.top
            right: root.right
            topMargin: 10
            rightMargin: 35
        }

        iconString: "󰈉"
        iconColor: Config.textColor
        clickAction: function () {
            root.hide();
        }
    }

    ClickableIcon {
        id: closeButton

        anchors {
            top: root.top
            right: root.right
            topMargin: 10
            rightMargin: 15
        }

        iconString: ""
        iconColor: Config.textColor
        clickAction: function () {
            root.dismiss();
        }
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 10
        width: parent.width - Config.notificationPadding

        Rectangle {
            id: iconBackground

            anchors.verticalCenter: parent.verticalCenter
            implicitHeight: Config.notificationHeight
            implicitWidth: Config.notificationHeight
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: {
                    root.hide();
                }
            }

            Loader {
                id: image
                active: root.modelData.hasImage
                visible: image.active
                asynchronous: true
                anchors.fill: parent

                Image {
                    anchors.fill: parent
                    source: Qt.resolvedUrl(root.modelData.image)
                    fillMode: Image.PreserveAspectCrop
                    cache: false
                    asynchronous: true
                }
            }

            Loader {
                id: appIcon
                active: root.modelData.hasAppIcon && !image.active
                visible: appIcon.active
                asynchronous: true
                anchors.fill: parent

                IconImage {
                    anchors.fill: parent
                    smooth: true
                    implicitSize: Config.notificationHeight
                    source: Quickshell.iconPath(root.modelData.appIcon)
                    asynchronous: true
                }
            }

            Loader {
                id: fallbackIcon
                active: !appIcon.active && !image.active
                visible: fallbackIcon.active
                asynchronous: true
                anchors.fill: parent

                Text {
                    anchors.centerIn: parent
                    text: "󰂚"
                    font.family: Config.iconFontFamily
                    font.pixelSize: Config.notificationHeight
                    color: Config.textColor
                }
            }
        }

        Column {
            id: textColumn
            property bool collapsed: true
            property int maxLength: 40
            property string bodyText: {
                if (!collapsed)
                    return root.modelData.body;
                let text = root.modelData.body;
                return text.length > textColumn.maxLength ? text.substring(0, textColumn.maxLength) + "..." : text;
            }

            width: contentRow.width - iconBackground.width - 25
            spacing: Config.notificationTextSpacing

            Text {
                text: root.modelData.summary
                width: parent.width
                color: Config.notificationTitleColor
                font.family: Config.textFontFamily
                font.pixelSize: Config.notificationTitleSize
                wrapMode: Text.Wrap
                visible: text !== ""
            }

            Text {
                text: textColumn.bodyText
                width: parent.width
                color: Config.notificationBodyColor
                font.family: Config.textFontFamily
                font.pixelSize: Config.notificationBodySize
                wrapMode: Text.Wrap
                visible: text !== ""

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                    onClicked: {
                        textColumn.collapsed = !textColumn.collapsed;
                        if (textColumn.collapsed)
                            root.modelData.timer.restart();
                        else
                            root.modelData.timer.stop();
                    }
                }
            }
        }
    }
}
