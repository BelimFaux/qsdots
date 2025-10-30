import QtQuick

import qs.widgets
import qs

ActionButton {
    id: root
    defaultColor: Theme.sessionButtonBackground
    hoverColor: Theme.sessionButtonSelectedBackground
    borderColor: Theme.sessionButtonBorder
    hoverBorderColor: Theme.sessionButtonSelectedBorder
    bWidth: Theme.sessionButtonWidth
    bHeight: Theme.sessionButtonHeight
    borderWidth: Theme.sessionButtonBorderWidth
    iconHeight: Theme.sessionButtonIconHeight
    textSize: Theme.sessionButtonTextSize

    onFocusChanged: {
        root.isHovered = root.focus;
    }

    onIsHoveredChanged: {
        root.focus = root.isHovered;
    }

    property Item previous
    property Item next
    property bool wantsQuit: false

    KeyNavigation.tab: next
    KeyNavigation.backtab: previous
    KeyNavigation.down: next
    KeyNavigation.up: previous

    Keys.onPressed: ev => {
        if (ev.key === Qt.Key_Enter || ev.key === Qt.Key_Return) {
            root.wantsQuit = true;
            root.click();
        } else if (ev.key === Qt.Key_Escape || ev.key === Qt.Key_Q) {
            root.wantsQuit = true;
        } else if (ev.key === Qt.Key_J) {
            next.forceActiveFocus();
        } else if (ev.key === Qt.Key_K) {
            previous.forceActiveFocus();
        }
    }
}
