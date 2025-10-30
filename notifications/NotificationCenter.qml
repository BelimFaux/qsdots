pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs
import qs.mediaplayer
import qs.services
import qs.widgets

LazyLoader {
    id: loader
    active: Notifications.ncActive

    PanelWindow {
        id: root
        anchors {
            top: true
            bottom: true
            right: Theme.notificationCenterRight
            left: !Theme.notificationCenterRight
        }
        margins {
            top: Theme.notificationCenterWindowMargin
            bottom: Theme.notificationCenterWindowMargin
            right: Theme.notificationCenterWindowMargin
        }

        WlrLayershell.namespace: "quickshell:notificationCenter"
        WlrLayershell.layer: WlrLayer.Overlay
        implicitWidth: Theme.notificationWidth + 2 * Theme.notificationCenterPadding
        color: "transparent"

        Rectangle {
            id: content
            anchors.fill: parent

            radius: 5
            border.width: Theme.componentBorderSize
            border.color: Theme.notificationCenterBorder
            color: Theme.notificationCenterBackground

            ColumnLayout {
                id: notificationColumn
                anchors.fill: parent
                anchors.margins: Theme.notificationCenterPadding

                spacing: Theme.notificationSpacing
                width: Theme.notificationWidth

                RowLayout {
                    id: buttonRow
                    Layout.alignment: Qt.AlignRight
                    spacing: Theme.notificationCenterSpacing

                    ClickableIcon {
                        id: doNotDisturb

                        iconString: Notifications.doNotDisturb ? "󰂛" : "󰂚"
                        iconColor: Theme.textColor
                        fontSize: Theme.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.doNotDisturb = !Notifications.doNotDisturb;
                        }
                    }

                    ClickableIcon {
                        id: clearAll

                        iconString: "󰗩"
                        iconColor: Theme.textColor
                        fontSize: Theme.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.clearAll();
                        }
                    }

                    ClickableIcon {
                        id: close

                        iconString: ""
                        iconColor: Theme.redColor
                        fontSize: Theme.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.ncActive = false;
                        }
                    }
                }

                ScrollView {
                    id: scrollContainer
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillHeight: true
                    Layout.topMargin: Theme.notificationCenterSpacing

                    ScrollBar.vertical: ScrollBar {
                        id: scrollBar
                        visible: Notifications.hasNotifs
                        parent: scrollContainer
                        x: scrollContainer.width
                        height: scrollContainer.height
                        contentItem: Rectangle {
                            implicitWidth: Theme.notificationCenterSpacing
                            radius: width / 2
                            color: scrollBar.pressed ? Theme.notificationCenterScrollbarActive : Theme.notificationCenterScrollbarInactive
                            opacity: scrollBar.active
                        }
                    }

                    Column {
                        Layout.margins: Theme.notificationCenterSpacing
                        spacing: Theme.notificationCenterSpacing

                        Repeater {
                            id: repeater
                            model: ScriptModel {
                                values: [...Notifications.list].reverse()
                            }

                            delegate: NotificationPopup {
                                onlyVisible: false
                            }
                        }
                    }
                }

                FullMediaPlayer {
                    implicitWidth: Theme.notificationWidth
                }
            }
        }
    }
}
