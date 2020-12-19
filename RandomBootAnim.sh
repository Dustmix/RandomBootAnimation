#!/system/bin/sh

# Variables
BOOTANIFOLDER=/sdcard/Bootanimations/
# Try replacing /system with /system/system/media if this doesn't work
SYSMEDIAPATH=/system/media

# Remount system
echo "Remounting system (rw)..."
mount -o rw,remount /system

# Search Bootanimation folder and setting it
if [[ -d "${BOOTANIFOLDER}" ]]; then
  echo "Bootanimation folder found! Selecting a random animation..."
  selected_zip=`find "${BOOTANIFOLDER}" -type f -iname \*.zip | shuf -n 1`
  echo "Setting animation... (${selected_zip})"
  cp ${selected_zip} ${SYSMEDIAPATH}/bootanimation.zip
else
  echo "Bootanimation folder not found. Searching original Bootanimation..."
  if [[ -f "${SYSMEDIAPATH}/bootanimation.zip_original" ]]; then
    echo "Original Bootanimation found, using that."
    cp ${SYSMEDIAPATH}/bootanimation.zip_original ${SYSMEDIAPATH}/bootanimation.zip
  else
    echo "Original Bootanimation not found. Quitting..."
    exit 1
  fi
fi

# Fix permissions
chmod 0644 ${SYSMEDIAPATH}/bootanimation.zip

# Remount system read-only
echo "Remounting system (ro) again...."
mount -o ro,remount /system

echo "Done"
exit 0
