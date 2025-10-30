import QtQuick

import qs.services
import qs.widgets
import qs

BarComponent {
    id: root
    content: Text {
        text: qsTr((Notifications.hasNotifs && !Notifications.doNotDisturb ? "󱅫 " : "") + Time.time)
        font.family: Theme.textFontFamily
        font.pointSize: Theme.fontSize
        color: Theme.textColor
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentHover
    borderColor: Theme.clockBorder

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
        borderColor: Theme.clockBorder

        content: Text {
            id: content
            text: qsTr((Notifications.ncActive ? "close" : "open") + " notification center")
            font.family: Theme.textFontFamily
            font.pixelSize: Theme.workspaceWindowTitleFontSize
            color: Theme.textColor
            padding: 5
        }
    }
}
