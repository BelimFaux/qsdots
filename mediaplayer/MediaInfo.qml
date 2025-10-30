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
        font.family: Theme.textFontFamily
        font.pointSize: Theme.fontSize
        color: Theme.textColor
    }

    Text {
        Layout.alignment: Qt.AlignCenter
        Layout.maximumWidth: root.width
        text: qsTr((root.player?.trackArtist ?? "") || "Unknown")
        clip: true
        elide: Text.ElideRight
        font.family: Theme.textFontFamily
        font.pointSize: Theme.mediaPlayerSmallFontSize
        color: Theme.textColor
    }
}
