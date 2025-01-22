#!/bin/bash

export dir_script=`dirname $0`
export dir_bin="/usr/bin"
export file_conf="/etc/syncfrom.conf"
export path_pc="`echo ~`"   # by default: home dir
export disk_name="snaifExHard"
export snaifServer_addr="snaiffer@95.181.246.219"
export snaifServer_port="2002"
export snaifServer_path="/store"

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
    echo -e "Error: Can't find the disk with such name."
    echo -e "Note: you have to mount your disk to PC\n"
    echo -e "Do you want to try again? (y/n) " && read answer
    if [ "$answer" = "n" ]; then break; fi
  done
  }

short_sync() {
  printf "Do you want the short sync (sync selected folders only)? (y/n) " && read answer
  if [ "$answer" = "y" ]; then
    short_sync="BasKet documents work unsorted"
    printf "\tShort sync turn on. Default list for sync: ($short_sync) " && read new_short_sync
    if [ "$new_short_sync" != "" ]; then short_sync="$new_short_sync"; fi
    #analize && break
  fi
  }

save_conf() {
  echo "export path_pc=$path_pc
# Detalization of rsync:
#     short	-- output aggreagtive progress information (one-line progress bar)
#     detail	-- output transfer of each file
export rsync_progress_mode=\"short\"

export path_disk=$path_disk
export snaifServer_addr=$snaifServer_addr
export snaifServer_port=$snaifServer_port
export snaifServer_path=$snaifServer_path" | sudo tee $file_conf > /dev/null
  if [ "$short_sync" != "" ]; then
    echo "
# Settings for selective synchronization
# write folders names through space; or delete this settings for full sync
export short_sync=\"$short_sync\"" | sudo tee -a $file_conf > /dev/null
  fi
  }

# auth. for sudo
sudo echo

echo "Installing syncfrom* scripts at the system..."
sudo cp -f $dir_script/syncfrom* $dir_bin/ && sudo chmod +x $dir_bin/syncfrom*
sudo cp -f $dir_script/.syncfrom* $dir_bin/ && sudo chmod +x $dir_bin/.syncfrom*

echo "Settings:"
get_path_pc
get_disk_name
short_sync
printf "Input address of snaifServer (By default: $snaifServer_addr): " && read new_snaifServer_addr
if [ "$new_snaifServer_addr" != "" ]; then snaifServer_addr=$new_snaifServer_addr; fi
printf "Input ssh-port of snaifServer (By default: $snaifServer_port): " && read new_snaifServer_port
if [ "$new_snaifServer_port" != "" ]; then snaifServer_port=$new_snaifServer_port; fi
printf "Input path to sync-directory of snaifServer (By default: $snaifServer_path): " && read new_snaifServer_path
if [ "$new_snaifServer_path" != "" ]; then snaifServer_path=$new_snaifServer_path; fi
save_conf

echo -e "done.\n"
