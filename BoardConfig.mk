#
# Copyright (C) 2019 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Basics & Paths
BOARD_VENDOR := xiaomi
DEVICE_PATH := device/xiaomi/begonia

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6785
TARGET_NO_BOOTLOADER := true

# Board Platform
TARGET_BOARD_PLATFORM := mt6785

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_USES_64_BIT_BINDER := true

# Kernel Rules
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_HEADER_SIZE := 1648
BOARD_KERNEL_PAGESIZE := 2048
BOARD_HASH_TYPE := sha1
BOARD_OS_VERSION := 9.0.0
BOARD_OS_PATCH_LEVEL := 2019-05
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x0bc08000
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --tags_offset $(BOARD_TAGS_OFFSET) --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.usbconfigfs=true
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# DTBO Rules
BOARD_RECOVERY_DTBO_SIZE := 122027
BOARD_RECOVERY_DTBO_OFFSET := 36173824
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(LOCAL_PATH)/prebuilt/dtbo.img
