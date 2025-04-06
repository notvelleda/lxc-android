msg "Mounting Android partitions..."

# this is specified to go before modules are loaded but like why the hell does it matter
echo "Mounting /config"
mount -t configfs -o nodev,noexec,nosuid none /config || emergency_shell # lib/systemd/system/config.mount

echo "Mounting most Android partitions"
/usr/lib/lxc-android/mount-android || emergency_shell # lib/systemd/system/android-mount.service

echo "Bind mounting files over /vendor"
/usr/bin/droid/bind_vendor.sh || emergency_shell # lib/systemd/system/bind-vendor.service

echo "Mounting /var/lib/lxc/android/rootfs"
mount -o ro,noatime /var/lib/lxc/android/android-rootfs.img /var/lib/lxc/android/rootfs || emergency_shell # lib/systemd/system/var-lib-lxc-android-rootfs.mount

echo "Mounting /system"
mount -t overlay -o lowerdir=/usr/lib/lxc-android/system:/var/lib/lxc/android/rootfs/system /var/lib/lxc/android/rootfs/system /system || emergency_shell # lib/systemd/system/system.mount
