rm -rf .repo/local_manifests/  && # Clone local_manifests repository
repo init --depth=1 -u https://github.com/AfterlifeOS/android_manifest.git -b 14 --git-lfs 
 git clone https://github.com/android-tweak/local_manifest_afterlife_rosemary --depth 1 -b main .repo/local_manifests && 
# Sync the repositories
/opt/crave/resync.sh  && 
# Set up build environment
export BUILD_USERNAME=mrsnailo 
 export BUILD_HOSTNAME=crave 
 source build/envsetup.sh && 
echo Repository: android-tweak/crave_aosp_builder
 echo Run ID: 11994763277
 
# Build the ROM
goafterlife rosemary
