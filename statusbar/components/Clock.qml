import QtQuick

import qs.services
import qs.widgets
import qs

BarComponent {
    id: root
    content: Text {
        text: qsTr((Notifications.hasNotifs && !Notifications.doNotDisturb ? "󱅫 " : "") + Time.time)
        font.family: Config.textFontFamily
        font.pointSize: Config.fontSize
        color: Config.textColor
    }
    bgColor: Config.componentBackground
    hoverColor: Config.componentHover
    borderColor: Config.clockBorder

    onClicked: () => {
        Notifications.ncActive = !Notifications.ncActive;
    }

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Config.clockBorder

        content: Text {
            id: content
            text: qsTr((Notifications.ncActive ? "close" : "open") + " notification center")
            font.family: Config.textFontFamily
            font.pixelSize: Config.workspaceWindowTitleFontSize
            color: Config.textColor
            padding: 5
        }
    }
}
