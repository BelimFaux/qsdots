//@ pragma UseQApplication

import Quickshell
import qs.osd
import qs.notifications
import qs.statusbar
import qs.lockscreen
import qs.session

ShellRoot {
    NotificationCenter {}
    NotificationPopupManager {}
    Lockscreen {}
    Bar {}
    Session {}
    Volume {}
    Brightness {}
}
