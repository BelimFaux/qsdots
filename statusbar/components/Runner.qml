import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs
import qs.services
import qs.widgets

BarComponent {
    id: root
    property bool windowOpen: ActiveWindow.isSome && Hyprland.monitorFor(screen).id == ActiveWindow.monitorId
    content: RowLayout {
        Text {
            text: Theme.runIcon
            color: Theme.textColor
            font.family: Theme.iconFontFamily
            font.pixelSize: Theme.iconHeight
        }
        Text {
            text: Theme.runText
            visible: !root.windowOpen
            opacity: root.windowOpen ? 0 : 1
            Layout.preferredWidth: root.windowOpen ? 0 : implicitWidth
            color: Theme.textColor
            font.family: Theme.textFontFamily
            font.pointSize: Theme.fontSize

            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentHover
    borderColor: Theme.runBorder

    onClicked: function () {
        Hyprland.dispatch("exec " + Theme.runCommand);
    }

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Theme.runBorder

        content: Text {
            id: content
            text: Theme.runText
            font.family: Theme.textFontFamily
            font.pixelSize: Theme.workspaceWindowTitleFontSize
            color: Theme.textColor
            padding: 5
        }
    }
}
