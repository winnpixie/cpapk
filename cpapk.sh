#!/system/bin/sh
# cpapk: A command-line APK 'extraction' tool that copies a desired application to /sdcard for Android devices.
# Author: Hannah (https://github.com/winnpixie)
# Source: https://github.com/winnpixie/cpapk/

if [[ $1 != "" ]]; then
    echo "Attempting to copy app '$1' to /sdcard/$1.apk"

    # Grab package
    package="$(pm list packages | grep -i $1 | awk -F ':' '{print $2}')"
    if [[ $package != "" ]]; then
        echo "Package found: $package"

        # Grab APK path
        apk_file="$(pm path $package | awk -F ':' '{print $2}' | grep -i '==/base.apk')"
        if [[ $apk_file != "" ]]; then
            echo "APK file found: $apk_file"

            # Copy APK file to /sdcard
            echo "Copying $apk_file to /sdcard/$1.apk"
            cp $apk_file "/sdcard/$1.apk"

            echo "Copy successful"
        else
            echo "APK file could not be located"
        fi
    else
        echo "Could not find package for $1, searching through System apps"

        # Grab directory from /system/app
        apk_file="$(ls /system/app | grep -i $1)"
        if [[ $apk_file != "" ]]; then
            echo "System APK file found: $apk_file.apk"

            # Copy APK file to /sdcard
            echo "Copying /system/app/$apk_file/$apk_file.apk to /sdcard/$apk_file.apk"
            cp /system/app/$apk_file/$apk_file.apk /sdcard/

            echo "Copy successful"
        else
            echo "System APK file could not be located"
        fi
    fi
    echo "Attempt completed"
else
    echo "usage: cpapk app_name"
fi