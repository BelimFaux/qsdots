import QtQuick

import qs.services
import qs

BarComponent {
    id: root
    content: Text {
        text: qsTr(Memory.freeMem + "/" + Memory.usedMem + " MiB")
        font.family: Theme.textFontFamily
        font.pointSize: Theme.fontSize
        color: Theme.textColor
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentBackground
    borderColor: Theme.memoryBorder
}
