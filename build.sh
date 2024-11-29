#!/bin/bash

# Clean up previous builds
echo "Removing local manifests..."
rm -rf .repo/local_manifests/  # Clone local_manifests repository

echo "Performing some cleanup..."
rm -rf hardware/xiaomi
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Initialize repo
echo "Initializing repo..."
if ! repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs; then
    echo "Repo initialization failed."
    exit 1
fi

echo "Cloning local manifests..."
if ! git clone https://github.com/android-tweak/local_manifest_afterlife_rosemary --depth 1 -b main .repo/local_manifests; then
    echo "Failed to clone local manifests."
    exit 1
fi

# Sync the repositories
echo "Syncing repositories..."
if ! /opt/crave/resync.sh; then
    echo "Resync failed."
    exit 1
fi

# Set up build environment
echo "Setting up the build environment..."
export BUILD_USERNAME="mrsnailo"
export BUILD_HOSTNAME="crave"
source build/envsetup.sh

# Build the ROM
echo "Building the ROM..."
goafterlife rosemary

echo "Build completed successfully!"
