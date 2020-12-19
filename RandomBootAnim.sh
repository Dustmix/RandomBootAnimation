#!/system/bin/sh

#
# RandomBootAnim was created by Dustmix
# Created on: 19/12/2020 (DD/MM/YYYY)
# Repo: https://github.com/Dustmix/RandomBootAnimation
#


# Variables
BOOTANIFOLDER=/sdcard/Bootanimations/
LOGGING=0
LOGFILE=/sdcard/RBA_log.log
KEEPOLDLOGS=0
# Try replacing /system with /system/system/media if this doesn't work
BOOTANIMATIONZIP=/system/media/bootanimation.zip

# Check if logging is enabled and if it is start logging
if [[ -f ${LOGFILE} ]]; then
  LOGGING=1
  if [ "${KEEPOLDLOGS}" -eq 1 ]; then
    echo "RBA started:" >> ${LOGFILE}
    date >> ${LOGFILE}
  else
    echo "RBA started:" > ${LOGFILE}
    date >> ${LOGFILE}
  fi
fi

# Remount system
if [ ${LOGGING} -eq 1 ]; then
  echo "Remounting system (rw)" >> ${LOGFILE}
  echo "Remounting system (rw)..."
  mount -o rw,remount /system
  echo "System remounted" >> ${LOGFILE}
else
  echo "Remounting system (rw)..."
  mount -o rw,remount /system
fi

# Backup Bootanimation if a backup doesn't exist
if [[ ! -f "${BOOTANIMATIONZIP}_original" ]]; then
  if [ ${LOGGING} -eq 1 ]; then
    echo "Backup doesn't exist, backing up original animation." >> ${LOGFILE}
    echo "Backing up original bootanimation..."
    cp ${BOOTANIMATIONZIP} "${BOOTANIMATIONZIP}_original"
    echo "bootanimation.zip backed up to /system/media/bootanimation.zip_original" >> ${LOGFILE}
  else
    echo "Backing up original bootanimation..."
    cp ${BOOTANIMATIONZIP} "${BOOTANIMATIONZIP}_original"
  fi
else
  if [ ${LOGGING} -eq 1 ]; then
      echo "Backup exists, continuing..." >> ${LOGFILE}
  fi
fi

# Search Bootanimation folder and setting it

if [ ${LOGGING} -eq 1 ]; then
  if [[ -d "${BOOTANIFOLDER}" ]]; then
    echo "Bootanimation folder was found, choosing a random animation" >> ${LOGFILE}
    echo "Bootanimation folder found! Selecting a random animation..."
    selected_zip=`find "${BOOTANIFOLDER}" -type f -iname \*.zip | shuf -n 1`
    echo "Replacing bootanimation.zip" >> ${LOGFILE}
    echo "Choosen animation: ${selected_zip}" >> ${LOGFILE}
    echo "Setting animation... (${selected_zip})"
    cp ${selected_zip} ${BOOTANIMATIONZIP}
    echo "bootanimation.zip replaced" >> ${LOGFILE}
  else
    echo "Bootanimation folder was not found, searching original bootanimation.zip" >> ${LOGFILE}
    echo "Bootanimation folder not found. Searching original Bootanimation..."
    if [[ -f "${BOOTANIMATIONZIP}_original" ]]; then
      echo "Original bootanimation.zip found, setting that as default bootanimation.zip" >> ${LOGFILE}
      echo "Original Bootanimation found, using that."
      cp "${BOOTANIMATIONZIP}_original" ${BOOTANIMATIONZIP}
      echo "bootanimation.zip replaced" >> ${LOGFILE}
    else
      echo "Original bootanimation.zip not found. Quitting..." >> ${LOGFILE}
      echo "Original Bootanimation not found. Quitting..."
      exit 1
    fi
  fi
else
  if [[ -d "${BOOTANIFOLDER}" ]]; then
    echo "Bootanimation folder found! Selecting a random animation..."
    selected_zip=`find "${BOOTANIFOLDER}" -type f -iname \*.zip | shuf -n 1`
    echo "Setting animation... (${selected_zip})"
    cp ${selected_zip} ${BOOTANIMATIONZIP}
  else
    echo "Bootanimation folder not found. Searching original Bootanimation..."
    if [[ -f "${BOOTANIMATIONZIP}_original" ]]; then
      echo "Original Bootanimation found, using that."
      cp "${BOOTANIMATIONZIP}_original" ${BOOTANIMATIONZIP}
    else
      echo "Original Bootanimation not found. Quitting..."
      exit 1
    fi
  fi
fi





# Fix permissions
if [ ${LOGGING} -eq 1 ]; then
  echo "Fixing permissions" >> ${LOGFILE}
  echo "Fixing permissions..."
  chmod 0644 ${BOOTANIMATIONZIP}
  echo "Permission fixed" >> ${LOGFILE}
else
  echo "Fixing permissions..."
  chmod 0644 ${BOOTANIMATIONZIP}
fi

# Remount system read-only
if [ ${LOGGING} -eq 1 ]; then
  echo "Remount system (ro)" >> ${LOGFILE}
  echo "Remounting system (ro) again...."
  mount -o ro,remount /system
  echo "System remounted" >> ${LOGFILE}
else
  echo "Remounting system (ro) again...."
  mount -o ro,remount /system
fi

echo "Done"
echo "Done" >> ${LOGFILE}
exit 0
