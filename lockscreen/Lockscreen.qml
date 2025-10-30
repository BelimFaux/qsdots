pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    LockContext {
        id: lockContext

        onUnlocked: {
            loader.unlock();
        }
    }

    LazyLoader {
        id: loader

        onActiveChanged: {
            if (item) {
                item.locked = loader.active;
            }
        }

        // locked has to be disabled before unloading
        function unlock() {
            item.locked = false;
            active = false;
        }

        WlSessionLock {
            id: lock
            locked: true

            WlSessionLockSurface {
                LockSurface {
                    anchors.fill: parent
                    context: lockContext
                }
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
