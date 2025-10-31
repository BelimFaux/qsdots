import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import qs
import qs.widgets

BarComponent {
    id: root
    visible: UPower.displayDevice.isLaptopBattery && UPower.displayDevice.state != UPowerDeviceState.FullyCharged
    content: RowLayout {
        Text {
            visible: UPower.displayDevice.state == UPowerDeviceState.Charging
            text: qsTr(Config.chargingIcon + " ")
            font.family: Config.iconFontFamily
            font.pixelSize: Config.iconHeight
            color: Config.textColor
        }
        Text {
            text: qsTr(Math.round(100 * UPower.displayDevice.percentage) + "%")
            font.family: Config.textFontFamily
            font.pointSize: Config.fontSize
            color: Config.textColor
        }
    }
    bgColor: Config.componentBackground
    hoverColor: Config.componentBackground
    borderColor: Config.batteryBorder

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Config.batteryBorder

        content: Text {
            id: content
            text: qsTr((UPower.displayDevice.state === UPowerDeviceState.Charging ? "+" : "-") + UPower.displayDevice.changeRate + " W")
            font.family: Config.textFontFamily
            font.pixelSize: Config.workspaceWindowTitleFontSize
            color: Config.textColor
            padding: 5
        }
    }
}
