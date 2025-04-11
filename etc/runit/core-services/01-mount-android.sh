msg "Mounting Android partitions (1/2)..."

echo " - Mounting /config..." # before local-fs
mount -t configfs -o nodev,noexec,nosuid none /config || emergency_shell # lib/systemd/system/config.mount

echo " - Mounting /var/lib/lxc/android/rootfs..." # wanted by local-fs, default dependencies: after local-fs? impossible with /system mount
mount -o ro,noatime /var/lib/lxc/android/android-rootfs.img /var/lib/lxc/android/rootfs || emergency_shell # lib/systemd/system/var-lib-lxc-android-rootfs.mount

echo " - Mounting /system..." # after var-lib-lxc-android-rootfs, before local-fs, systemd-modules-load
mount -t overlay -o lowerdir=/usr/lib/lxc-android/system:/var/lib/lxc/android/rootfs/system /var/lib/lxc/android/rootfs/system /system || emergency_shell # lib/systemd/system/system.mount
