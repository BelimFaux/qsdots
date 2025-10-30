import QtQuick
import Quickshell.Hyprland

import qs.services
import qs

BarComponent {
    id: root
    readonly property int maxLength: 50

    visible: ActiveWindow.isSome && Hyprland.monitorFor(screen).id == ActiveWindow.monitorId
    content: Text {
        id: windowName
        anchors.verticalCenter: parent.verticalCenter
        text: {
            let text = ActiveWindow.name;
            if (text.length > root.maxLength) {
                text = text.substring(0, root.maxLength) + "...";
            }
            return text;
        }
        font.family: Theme.textFontFamily
        font.pointSize: Theme.fontSize
        color: Theme.textColor
    }

    bgColor: Theme.componentBackground
    hoverColor: Theme.componentBackground
    borderColor: Theme.windowNameBorder
}
