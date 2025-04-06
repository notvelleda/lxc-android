msg "Starting Android container..."

/usr/bin/lxc-start -n android -d
/usr/lib/lxc-android/lxc-android-notify
/usr/bin/droid/enable-wifi.sh
