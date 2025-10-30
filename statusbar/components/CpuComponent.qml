import QtQuick

import qs.services
import qs

BarComponent {
    content: Text {
        text: qsTr(Cpu.temp + (Cpu.fanSpeed !== "" ? " | " + Cpu.fanSpeed : ""))
        font.family: Theme.textFontFamily
        font.pointSize: Theme.fontSize
        color: Theme.textColor
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentBackground
    borderColor: Theme.cpuBorder
}
