#!/system/bin/sh
# cpapk: A command-line APK 'extraction' tool that copies a desired application to /sdcard for Android devices.
# Author: Hannah (https://github.com/winnpixie)
# Source: https://github.com/winnpixie/cpapk/

if [[ $1 != "" ]]; then
	echo "Attempting to copy app '$1' to /sdcard/$1.apk"

	pkg_list="$(pm list packages 2>&1 </dev/null)"
	parsed_pkg="$(echo "$pkg_list" | grep -i $1 | awk -F ':' '{print $2}')"
	if [[ $parsed_pkg != "" ]]; then
		echo "Package found: $parsed_pkg"

		# Grab APK path
		apk_path="$(pm path $parsed_pkg 2>&1 </dev/null)"
		apk_file="$(echo "$apk_path" | awk -F ':' '{print $2}' | grep -i '==/base.apk')"
		if [[ $apk_file != "" ]]; then
			echo "APK file found: $apk_file"

			# Copy APK file to /sdcard
			echo "Copying $apk_file to /sdcard/$1.apk"
			cp $apk_file "/sdcard/$1.apk"

			echo "Copy successful"
			return 0 2>/dev/null || exit 0
		fi
	fi

	echo "Could not find package for '$1', searching System apps"

	# Test system paths
	for sys_path in "/system/app" "/system/priv-app" "/system_ext/app" "/system_ext/priv-app"; do
		apk_file="$(ls $sys_path | grep -i $1)"

		if [[ $apk_file != "" ]]; then
			echo "System app '$apk_file.apk' found in $sys_path"
			
			# Copy APK to /sdcard/
			echo "Copying $sys_path/$apk_file/$apk_file.apk to /sdcard/$apk_file.apk"
			cp $sys_path/$apk_file/$apk_file.apk /sdcard/$apk_file.apk

			echo "Copy successful"
			return 0 2>/dev/null || exit 0
		fi
	done

	echo "Could not find System app, are you sure '$1' exists?"
else
	echo "usage: cpapk app_name"
fi