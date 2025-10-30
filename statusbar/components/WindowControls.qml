import QtQuick
import Quickshell.Hyprland

import qs.services
import qs.widgets
import qs

BarComponent {
    id: root
    readonly property int maxLength: 50

    visible: ActiveWindow.isSome && Hyprland.monitorFor(screen).id == ActiveWindow.monitorId
    content: Row {
        spacing: 5

        ClickableIcon {
            id: specialButton
            iconString: ActiveWindow.isSpecial ? Hyprland.focusedWorkspace.name : ""
            iconColor: Theme.yellowColor
            clickAction: function () {
                if (ActiveWindow.isSpecial) {
                    ActiveWindow.moveToWorkspace(Hyprland.focusedWorkspace.name);
                } else {
                    ActiveWindow.moveToWorkspace("special:scratchpad");
                }
            }
            fontSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        ClickableIcon {
            iconString: ActiveWindow.isFullscreen ? "󰘕" : "󰘖"
            iconColor: Theme.greenColor
            clickAction: function () {
                ActiveWindow.fullscreen(false);
            }
            doubleClickAction: function () {
                ActiveWindow.fullscreen(true);
            }
            fontSize: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        ClickableIcon {
            iconString: ""
            iconColor: Theme.redColor
            clickAction: function () {
                ActiveWindow.close();
            }
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    bgColor: Theme.componentBackground
    hoverColor: Theme.componentBackground
    borderColor: Theme.windowControlsBorder
}
