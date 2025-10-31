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
            right: Config.notificationCenterRight
            left: !Config.notificationCenterRight
        }
        margins {
            top: Config.notificationCenterWindowMargin
            bottom: Config.notificationCenterWindowMargin
            right: Config.notificationCenterWindowMargin
        }

        WlrLayershell.namespace: "quickshell:notificationCenter"
        WlrLayershell.layer: WlrLayer.Overlay
        implicitWidth: Config.notificationWidth + 2 * Config.notificationCenterPadding
        color: "transparent"

        Rectangle {
            id: content
            anchors.fill: parent

            radius: 5
            border.width: Config.componentBorderSize
            border.color: Config.notificationCenterBorder
            color: Config.notificationCenterBackground

            ColumnLayout {
                id: notificationColumn
                anchors.fill: parent
                anchors.margins: Config.notificationCenterPadding

                spacing: Config.notificationSpacing
                width: Config.notificationWidth

                RowLayout {
                    id: buttonRow
                    Layout.alignment: Qt.AlignRight
                    spacing: Config.notificationCenterSpacing

                    ClickableIcon {
                        id: doNotDisturb

                        iconString: Notifications.doNotDisturb ? "󰂛" : "󰂚"
                        iconColor: Config.textColor
                        fontSize: Config.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.doNotDisturb = !Notifications.doNotDisturb;
                        }
                    }

                    ClickableIcon {
                        id: clearAll

                        iconString: "󰗩"
                        iconColor: Config.textColor
                        fontSize: Config.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.clearAll();
                        }
                    }

                    ClickableIcon {
                        id: close

                        iconString: ""
                        iconColor: Config.notificationCenterClose
                        fontSize: Config.notificationCenterIconSize
                        clickAction: function () {
                            Notifications.ncActive = false;
                        }
                    }
                }

                ScrollView {
                    id: scrollContainer
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillHeight: true
                    Layout.topMargin: Config.notificationCenterSpacing

                    ScrollBar.vertical: ScrollBar {
                        id: scrollBar
                        visible: Notifications.hasNotifs
                        parent: scrollContainer
                        x: scrollContainer.width
                        height: scrollContainer.height
                        contentItem: Rectangle {
                            implicitWidth: Config.notificationCenterSpacing
                            radius: width / 2
                            color: scrollBar.pressed ? Config.notificationCenterScrollbarActive : Config.notificationCenterScrollbarInactive
                            opacity: scrollBar.active
                        }
                    }

                    Column {
                        Layout.margins: Config.notificationCenterSpacing
                        spacing: Config.notificationCenterSpacing

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
                    implicitWidth: Config.notificationWidth
                }
            }
        }
    }
}
