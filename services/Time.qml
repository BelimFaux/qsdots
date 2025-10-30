pragma Singleton

import Quickshell
import qs

Singleton {
    id: root

    function formattedTime(format) {
        return Qt.formatDateTime(clock.date, format);
    }

    property string time: {
        Qt.formatDateTime(clock.date, Theme.timeFormat);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
