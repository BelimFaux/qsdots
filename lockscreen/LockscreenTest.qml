pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io

Scope {
    LockContext {
        id: lockContext

        onUnlocked: {
            loader.unlock();
        }
    }

    LazyLoader {
        id: loader

        // locked has to be disabled before unloading
        function unlock() {
            active = false;
        }

        FloatingWindow {
            id: lock

            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }

    IpcHandler {
        target: "lockscreen"

        function lock(): void {
            if (!loader.active)
                loader.activeAsync = true;
        }
    }
}
