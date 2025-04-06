msg "Waiting for Android container to stop..."
/usr/bin/droid/disable-wifi.sh
/usr/lib/lxc-android/lxc-android-stop
