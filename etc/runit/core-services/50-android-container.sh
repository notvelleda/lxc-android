msg "Starting Android container..."

/usr/bin/lxc-start -n android -d || emergency_shell
/usr/lib/lxc-android/lxc-android-notify
/usr/bin/droid/enable-wifi.sh
