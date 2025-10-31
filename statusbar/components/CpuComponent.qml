import QtQuick

import qs.services
import qs

BarComponent {
    content: Text {
        text: qsTr(Cpu.temp + (Cpu.fanSpeed !== "" ? " | " + Cpu.fanSpeed : ""))
        font.family: Config.textFontFamily
        font.pointSize: Config.fontSize
        color: Config.textColor
    }
    bgColor: Config.componentBackground
    hoverColor: Config.componentBackground
    borderColor: Config.cpuBorder
}
