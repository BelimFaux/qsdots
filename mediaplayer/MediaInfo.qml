import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs

ColumnLayout {
    id: root
    required property MprisPlayer player
    spacing: 2

    Text {
        Layout.alignment: Qt.AlignCenter
        Layout.maximumWidth: root.width
        text: qsTr((root.player?.trackTitle ?? "") || "Untitled")
        clip: true
        elide: Text.ElideRight
        font.family: Config.textFontFamily
        font.pointSize: Config.fontSize
        color: Config.textColor
    }

    Text {
        Layout.alignment: Qt.AlignCenter
        Layout.maximumWidth: root.width
        text: qsTr((root.player?.trackArtist ?? "") || "Unknown")
        clip: true
        elide: Text.ElideRight
        font.family: Config.textFontFamily
        font.pointSize: Config.mediaPlayerSmallFontSize
        color: Config.textColor
    }
}
