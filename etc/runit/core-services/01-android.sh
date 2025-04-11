msg "Mounting Android partitions..."

echo " - Mounting /config..." # before local-fs
mount -t configfs -o nodev,noexec,nosuid none /config || emergency_shell # lib/systemd/system/config.mount

echo " - Mounting /var/lib/lxc/android/rootfs..." # wanted by local-fs, default dependencies: after local-fs? impossible with /system mount
mount -o ro,noatime /var/lib/lxc/android/android-rootfs.img /var/lib/lxc/android/rootfs || emergency_shell # lib/systemd/system/var-lib-lxc-android-rootfs.mount

echo " - Mounting /system..." # after var-lib-lxc-android-rootfs, before local-fs, systemd-modules-load
mount -t overlay -o lowerdir=/usr/lib/lxc-android/system:/var/lib/lxc/android/rootfs/system /var/lib/lxc/android/rootfs/system /system || emergency_shell # lib/systemd/system/system.mount

echo " - Mounting most Android partitions..." # after local-fs, systemd-remount-fs, required by local-fs
/usr/lib/lxc-android/mount-android || emergency_shell # lib/systemd/system/android-mount.service

echo " - Bind mounting files over /vendor..." # after android-mount, wanted by local-fs
/usr/bin/droid/bind_vendor.sh || emergency_shell # lib/systemd/system/bind-vendor.service

msg "Starting Android container..."

/usr/bin/lxc-start -n android -d || emergency_shell
/usr/lib/lxc-android/lxc-android-notify
/usr/bin/droid/enable-wifi.sh
