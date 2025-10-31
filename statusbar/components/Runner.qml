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
            text: Config.runIcon
            color: Config.textColor
            font.family: Config.iconFontFamily
            font.pixelSize: Config.iconHeight
        }
        Text {
            text: Config.runText
            visible: !root.windowOpen
            opacity: root.windowOpen ? 0 : 1
            Layout.preferredWidth: root.windowOpen ? 0 : implicitWidth
            color: Config.textColor
            font.family: Config.textFontFamily
            font.pointSize: Config.fontSize

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
    bgColor: Config.componentBackground
    hoverColor: Config.componentHover
    borderColor: Config.runBorder

    onClicked: function () {
        Hyprland.dispatch("exec " + Config.runCommand);
    }

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Config.runBorder

        content: Text {
            id: content
            text: Config.runText
            font.family: Config.textFontFamily
            font.pixelSize: Config.workspaceWindowTitleFontSize
            color: Config.textColor
            padding: 5
        }
    }
}
