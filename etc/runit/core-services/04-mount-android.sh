msg "Mounting Android partitions (2/2)..."

echo " - Mounting most Android partitions..." # after local-fs, systemd-remount-fs, required by local-fs
/usr/lib/lxc-android/mount-android || emergency_shell # lib/systemd/system/android-mount.service

echo " - Bind mounting files over /vendor..." # after android-mount, wanted by local-fs
/usr/bin/droid/bind_vendor.sh || emergency_shell # lib/systemd/system/bind-vendor.service
