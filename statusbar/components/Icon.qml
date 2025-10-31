import QtQuick
import Quickshell.Hyprland

import qs
import qs.widgets

BarComponent {
    id: root
    content: Text {
        text: Config.distroIcon
        color: Config.distroColor
        font.family: Config.iconFontFamily
        font.pixelSize: Config.iconHeight
    }
    bgColor: Config.componentBackground
    hoverColor: Config.componentHover
    borderColor: Config.iconBorder

    onClicked: function () {
        Hyprland.dispatch("exec qs ipc call session toggle");
    }

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Config.iconBorder

        content: Text {
            id: content
            text: "open session menu"
            font.family: Config.textFontFamily
            font.pixelSize: Config.workspaceWindowTitleFontSize
            color: Config.textColor
            padding: 5
        }
    }
}
