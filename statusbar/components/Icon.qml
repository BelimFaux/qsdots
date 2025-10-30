import QtQuick
import Quickshell.Hyprland

import qs
import qs.widgets

BarComponent {
    id: root
    content: Text {
        text: Theme.distroIcon
        color: Theme.distroColor
        font.family: Theme.iconFontFamily
        font.pixelSize: Theme.iconHeight
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentHover
    borderColor: Theme.iconBorder

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
        borderColor: Theme.iconBorder

        content: Text {
            id: content
            text: "open session menu"
            font.family: Theme.textFontFamily
            font.pixelSize: Theme.workspaceWindowTitleFontSize
            color: Theme.textColor
            padding: 5
        }
    }
}
