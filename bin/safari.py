#!/usr/bin/env python
# -*- coding: utf-8 -*-

from watchdog import Watchdog

if __name__ == "__main__":
    Watchdog(["osascript", "-e", """tell application "Safari"
            do JavaScript "window.location.reload()" in front document
        end tell"""]).run()
