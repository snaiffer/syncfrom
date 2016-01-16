#!/bin/bash

export dir_script=`dirname $0`
export dir_bin="/usr/bin"
export file_conf="/etc/syncfrom.conf"
export path_pc="/home/snaiffer"
export disk_name="snaifExHard"

analize_path_pc() {
  path_pc=`echo $path_pc | sed "s/\/$//" | sed "s/\/sync$//"`
  ls $path_pc &> /dev/null
  if [ "$?" = "0" ] && [ "$path_pc" != "" ]; then
    return 0
  fi
  return 1
  }

get_path_pc() {
  while true; do
    printf "Enter the path to \"sync\" directory on your pc: ($path_pc) " && read new_path_pc
    if [ "$new_path_pc" != "" ]; then path_pc=$new_path_pc; fi
    analize_path_pc && break
    echo -e "The path is broken. Try again.\n"
  done
  }

analize_disk_name() {
  export path_disk=`mount | grep --color=never "/$disk_name\ " | sed "s/.*on\ //" | sed "s/\ type\ .*//"`
  if [ "$path_disk" = "" ]; then return 1; fi
  return 0
  }

get_disk_name() {
  while true; do
    printf "Enter the disk name: ($disk_name) " && read new_disk_name
    if [ "$new_disk_name" != "" ]; then disk_name=$new_disk_name; fi
    analize_disk_name && break
    echo -e "The disk name is wrong. Try again.\n"
  done
  }

save_conf() {
  sudo echo "export path_pc=$path_pc
export path_disk=$path_disk" > $file_conf
  }


echo "Installing syncfrom* scripts at the system..."
sudo cp -f $dir_script/syncfrom* $dir_bin/ && sudo chmod +x $dir_bin/syncfrom*

echo "Settings:"
get_path_pc
get_disk_name
save_conf

echo -e "done.\n"
