#!/bin/sh

#droid-hal-cosmopda-bin had these, uncertain if they are needed with the new LineageOS based generic android rootfs
#mount -o ro,bind /usr/libexec/droid-hybris/vendor/lib64/hw/audio.primary.mt6771.so /vendor/lib64/hw/audio.primary.mt6771.so
#mount -o ro,bind /usr/libexec/droid-hybris/vendor/lib64/libmtk-ril.so /vendor/lib64/libmtk-ril.so

#disable secure_element and keymaster as tyey always fail
mount -o ro,bind /dev/null /vendor/etc/init/android.hardware.secure_element@1.0-service.rc
mount -o ro,bind /dev/null /vendor/etc/init/android.hardware.keymaster@3.0-service.rc
