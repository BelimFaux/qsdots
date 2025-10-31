import QtQuick

import qs.services
import qs

BarComponent {
    id: root
    content: Text {
        text: qsTr(Memory.freeMem + "/" + Memory.usedMem + " MiB")
        font.family: Config.textFontFamily
        font.pointSize: Config.fontSize
        color: Config.textColor
    }
    bgColor: Config.componentBackground
    hoverColor: Config.componentBackground
    borderColor: Config.memoryBorder
}
