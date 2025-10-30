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
            text: qsTr(Theme.chargingIcon + " ")
            font.family: Theme.iconFontFamily
            font.pixelSize: Theme.iconHeight
            color: Theme.textColor
        }
        Text {
            text: qsTr(Math.round(100 * UPower.displayDevice.percentage) + "%")
            font.family: Theme.textFontFamily
            font.pointSize: Theme.fontSize
            color: Theme.textColor
        }
    }
    bgColor: Theme.componentBackground
    hoverColor: Theme.componentBackground
    borderColor: Theme.batteryBorder

    onHovered: function () {
        tooltip.visible = !tooltip.visible;
    }

    TooltipWindow {
        id: tooltip
        anchorItem: root
        visible: false
        borderColor: Theme.batteryBorder

        content: Text {
            id: content
            text: qsTr((UPower.displayDevice.state === UPowerDeviceState.Charging ? "+" : "-") + UPower.displayDevice.changeRate + " W")
            font.family: Theme.textFontFamily
            font.pixelSize: Theme.workspaceWindowTitleFontSize
            color: Theme.textColor
            padding: 5
        }
    }
}
