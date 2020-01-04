# cpapk
A command-line APK 'extraction' tool that copies a desired application to /sdcard for Android devices.

## Prerequisites:
* An Android device
* [Android Debug Bridge (adb)](https://developer.android.com/studio/command-line/adb)

## How to use:
* Make sure USB debugging is enabled on your device
* Connect your device and start the adb server (``adb start-server``)
* Accept the debug popup (if prompted)
* Run ``adb push cpapk /sdcard``
* Run ``adb shell sh /sdcard/cpapk app_name`` (replace app_name with the desired application)

## Notes:
* You may be required to run ``dos2unix`` on the ``cpapk`` executable (``adb shell dos2unix /sdcard/cpapk``)
    * I tried to force commits to use LF instead of CRLF but I'm not sure if it worked.