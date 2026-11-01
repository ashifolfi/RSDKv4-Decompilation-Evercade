#!/bin/bash
SDCARD=$(realpath $(dirname ${BASH_SOURCE[0]})/..)

grep "Evercade RootFS" /etc/rootfs_version
if [[ $? == 0 ]]; then
	export IS_HH=true
else
	export IS_HH=false
fi

function set_perf()
{
	[ $IS_HH == false ] && return
	export CPU_GOVERNOR=$(< /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)
	echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	killItWithFire
}

function unset_perf()
{
	# Return if not handheld
	[ $IS_HH == false ] && return
	echo "$CPU_GOVERNOR" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	unset CPU_GOVERNOR
	unset IS_HH
	gameOn &
}

# Set the sound device to HDMI where needed
aplay -D plughw:0,1 /dev/null && export ALSA_PCM_DEVICE=1

set_perf

env \
    LD_LIBRARY_PATH="${SDCARD}/RSDKv4" \
    HOME="${SDCARD}/RSDKv4/S2" \
    /lib/ld-linux-armhf.so.3 ${SDCARD}/RSDKv4/RSDKv4 \
    gamedir="${SDCARD}/RSDKv4/S2"

unset_perf
