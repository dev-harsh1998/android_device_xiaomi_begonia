#!sbin/sh

#
# use ro.build.fingerprint,
# use ro.build.version.release, ro.build.version.security_patch, ro.vendor.build.security_patch
# from system/build.prop or vendor/build.prop instead of default.prop
#
# for noAB slot
# for BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
# for vendor/build.prop
# for keymaster-3.0+
#
#

SYSTEM_TMP=/supersu/system_tmp
VENDOR_TMP=/supersu/vendor_tmp

#systempart
for i in $(seq 0 90)
do
  systempart=`find /dev/block -name system | grep "by-name/system" -m 1 2>/dev/null`
  [ -z "$systempart" ] || break
  usleep 100000
done
[ -z "$systempart" ] && setprop "twrp.fingerprintid.prop" "0"
#[ -z "$systempart" ] && setprop "twrp.fingerprintid.system" "none"
[ -z "$systempart" ] && exit 1

#vendorpart
vendorpart=`find /dev/block -name vendor | grep "by-name/vendor" -m 1 2>/dev/null`

mkdir -p "$SYSTEM_TMP"
mount -t ext4 -o ro "$systempart" "$SYSTEM_TMP"
usleep 100

temp=`cat "$SYSTEM_TMP/system/build.prop" /system_root/system/build.prop /system/system/build.prop /default.prop 2>/dev/null`

fingerprint=`echo "$temp" | grep -F "ro.build.fingerprint=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.fingerprint" "$fingerprint" &
RELEASE=`echo "$temp" | grep -F "ro.build.version.release=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.release" "$RELEASE" &
PATCH=`echo "$temp" | grep -F "ro.build.version.security_patch=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.security_patch" "$PATCH" &
SDK=`echo "$temp" | grep -F "ro.build.version.sdk=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.sdk" "$SDK" &


#vendorpart
if [ ! -z "$vendorpart" ]; then

  setprop "twrp.fingerprintid.vendor" "$vendorpart" &

  mkdir -p "$VENDOR_TMP"
  mount -t ext4 -o ro "$vendorpart" "$VENDOR_TMP"
  usleep 100

  VENPATCH=`cat "$VENDOR_TMP/build.prop" /vendor/build.prop /default.prop 2>/dev/null | grep -F "ro.vendor.build.security_patch=" -m 1 | cut -d'=' -f2`

  resetprop "ro.vendor.build.security_patch" "$VENPATCH" &

  umount "$VENDOR_TMP" &

fi

setprop "twrp.fingerprintid.prop" "1" &
setprop "twrp.fingerprintid.system" "$systempart" &

umount "$SYSTEM_TMP"

setprop "twrp.fingerprintid.sys_root" "1" &

sleep 2

exit 0




