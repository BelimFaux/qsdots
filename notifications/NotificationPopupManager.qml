pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland

import qs
import qs.services

LazyLoader {
    active: Notifications.visible.length > 0 && !Notifications.ncActive

    PanelWindow {
        id: popupTray
        implicitWidth: Theme.notificationWidth
        color: "transparent"
        focusable: false

        WlrLayershell.namespace: "quickshell:notificationPopups"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusiveZone: 0

        anchors.top: true
        anchors.right: true
        anchors.bottom: true
        margins.top: Theme.notificationMargin
        margins.right: Theme.notificationMargin
        margins.bottom: Theme.notificationMargin

        property int spacing: Theme.notificationSpacing

        Column {
            id: notificationColumn
            anchors.right: parent.right
            spacing: popupTray.spacing
            width: parent.width

            Repeater {
                model: ScriptModel {
                    values: [...Notifications.visible].reverse()
                }

                delegate: NotificationPopup {}
            }
        }
    }
}
