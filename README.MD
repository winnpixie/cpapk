# cpapk
A command-line APK 'extraction' tool that copies a desired application to /sdcard for Android devices.

## Prerequisites:
* An Android device
* [Android Debug Bridge (adb)](https://developer.android.com/studio/command-line/adb) or [Termux](https://termux.com)

## How to use (adb):
* Make sure USB debugging is enabled on your device
* Connect your device and start the adb server (``adb start-server``)
* Accept the debug popup (if prompted)
* Run ``adb push cpapk /sdcard``
* Run ``adb shell sh /sdcard/cpapk app_name`` (replace ``app_name`` with the desired application)

## How to use (Termux):
* Install [Termux](https://termux.com/) on your device
* (this is a one-time step) Run ``termux-setup-storage`` to allow Termux file access
* Run ``cd /sdcard``
* (this is a one-time) Run ``curl -o cpapk https://raw.githubusercontent.com/alerithe/cpapk/master/cpapk`` to download the executable
* Run ``bash cpapk app_name`` (replace ``app_name`` with the desired application)

## Notes:
* You may be required to run ``dos2unix`` on the ``cpapk`` executable (``adb shell dos2unix /sdcard/cpapk`` or just ``dos2unix /sdcard/cpapk`` if you're on Termux).
    * I tried to force commits to use LF instead of CRLF but I'm not sure if it worked.
* Running through Termux on a non-rooted device does not work for any non-System apps and will require an app from the Play Store.
    * I can't confirm if this problem persists on a rooted device also because I don't own one.