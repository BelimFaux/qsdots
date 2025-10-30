import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs
import qs.widgets

RowLayout {
    id: root
    required property MprisPlayer player
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignCenter
    Layout.margins: 10
    spacing: Theme.mediaPlayerButtonSpacing

    ClickableIcon {
        iconString: "󰒮"
        iconColor: (root.player?.canGoPrevious ?? false) ? Theme.textColor : Theme.mediaPlayerButtonInactive
        fontSize: Theme.mediaPlayerButtonSize
        clickAction: function () {
            if (root.player.canGoPrevious)
                root.player.previous();
        }
    }

    ClickableIcon {
        iconString: (root.player?.isPlaying ?? false) ? "󰏤" : "󰐊"
        iconColor: (root.player?.canTogglePlaying ?? false) ? Theme.textColor : Theme.mediaPlayerButtonInactive
        fontSize: Theme.mediaPlayerButtonSize
        clickAction: function () {
            if (root.player.canTogglePlaying)
                root.player.togglePlaying();
        }
    }

    ClickableIcon {
        iconString: "󰒭"
        iconColor: (root.player?.canGoNext ?? false) ? Theme.textColor : Theme.mediaPlayerButtonInactive
        fontSize: Theme.mediaPlayerButtonSize
        clickAction: function () {
            if (root.player.canGoNext)
                root.player.next();
        }
    }
}
