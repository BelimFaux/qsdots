pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

import qs

Singleton {
    id: root
    property bool ncActive: false
    property bool doNotDisturb: false
    readonly property var list: []
    readonly property var visible: list.filter(n => !doNotDisturb && n.visible)
    readonly property bool hasNotifs: list.length > 0

    function clearAll(): void {
        root.list.forEach(n => n.dismiss());
    }

    IpcHandler {
        id: commands
        target: "notification"

        function toggle(): void {
            root.ncActive = !root.ncActive;
        }

        function toggleDisturb(): void {
            root.doNotDisturb = !root.doNotDisturb;
        }
    }

    component Notif: QtObject {
        id: notif

        property bool visible
        property Notification notification
        property string summary: notification.summary
        property string body: notification.body
        property string appIcon: notification.appIcon
        property bool hasAppIcon: notif.appIcon.length > 0
        property string image: notification.image
        property bool hasImage: notif.image.length > 0
        property int urgency: notification.urgency

        property var hideNotif: () => {
            notif.visible = false;
        }

        property var dismiss: () => {
            notif.notification.dismiss();
        }

        property Timer timer: Timer {
            running: true
            interval: notif.notification.expireTimeout > 0 ? notif.notification.expireTimeout : Config.notificationDefaultTimeout
            onTriggered: {
                if (notif !== null) {
                    notif.hideNotif();
                }
            }
        }

        readonly property Connections conn: Connections {
            target: notif.notification.Retainable

            function onDropped(): void {
                root.list.splice(root.list.findIndex(n => n.notification.id === notif.notification.id), 1);
            }

            function onAboutToDestroy(): void {
                notif.destroy();
            }
        }
    }

    Component {
        id: notifComp
        Notif {}
    }

    NotificationServer {
        id: server
        imageSupported: true
        bodySupported: true
        bodyMarkupSupported: true
        bodyImagesSupported: true

        onNotification: function (notification) {
            notification.tracked = true;
            if (notification == null || notification.lastGeneration)
                return;

            root.list.push(notifComp.createObject(root, {
                visible: true,
                notification: notification
            }));
        }
    }
}
