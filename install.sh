#!/bin/bash

export dir_script=`dirname $0`
export dir_bin="/usr/bin"
export file_conf="/etc/syncfrom.conf"
export disk_name="snaifExHard"
export snaifServer_addr="snaiffer@95.181.246.219"
export snaifServer_port="2002"
export snaifServer_path="/store"
export items4sync=""
export exHard_path=""

export b=$(tput bold)   # bold text
export n=$(tput sgr0)   # normal text
export yellow="\033[1;33;40m"   # yellow text

actual_user=$USER

exHard_path_root=""
analize_disk_name() {
    exHard_path_root=`mount | grep --color=never "/$disk_name\ " | sed "s/.*on\ //" | sed "s/\ type\ .*//"`
    if [ "$exHard_path_root" = "" ]; then return 1; fi
    return 0
}

get_exHard_disk_name() {
    echo -e "\n${b}Detecting path to exHard (external mounted flash)${n}"
    while true; do
        printf "\t Enter the disk name (default: %s): " $disk_name && read new_disk_name
        if [ -n "$new_disk_name" ]; then
            disk_name=$new_disk_name;
        fi
        analize_disk_name && break
        echo -e "${yellow}Error: Can't find a disk with a such name.${n} You have to mount your disk to PC"
        printf "Do you want to try again? (y/n) " && read answer
        if [ "$answer" == "n" ]; then break; fi
    done
}

get_exHard_path() {
    echo -e "\n${b}Detecting path to \"sync\" path on exHard (external mounted flash)${n}"
    exHard_path="${exHard_path_root}/sync"
    while true; do
        printf "\t Enter the path (default: %s): " $exHard_path && read new_exHard_path
        if [[ -n "$new_exHard_path" ]]; then exHard_path=$new_exHard_path; fi
        echo "$exHard_path" | grep -e "^$exHard_path_root" &> /dev/null
        if [[ "$?" == "0" ]]; then break; fi;
        echo -e "${yellow}Error: The path should begin with \"${exHard_path_root}\".${n} Try again.\n"
    done

    mkdir -p ${exHard_path}
    chown -R $USER:$USER ${exHard_path}
}

get_items4sync() {
    while true; do
        echo -e "\n${b}Input full pathes to items for sync on your PC:${n}"
        items4sync=""
        while true; do
            printf "\t Enter the path to a new item (leave empty to finish): "; read newitem
            if [[ -z "$newitem" ]]; then
                break;
            fi
            if [[ "$newitem" =~ \" ]]; then
                echo -e "${yellow}The string shouldn't contains a double quote. Try again.${n}"
                continue;
            fi
            items4sync=$(printf "%s \\\\\n\t%s" "$items4sync" "$newitem")
        done

        printf "\n\t${b}The final items4sync:${n}"
        echo "$items4sync"

        printf "\n Is it correct? (y/n): "; read answer
        if [[ "$answer" == "y" || "$answer" == "Y" || "$answer" == "yes" || "$answer" == "YES" ]]; then
            break;
        fi
        echo -e "\n${yellow}Try again.${n}"
    done
}

save_conf() {
  echo "
#############################################
# Configuration file for syncfrom_* scripts #
#############################################

# Detalization of rsync:
#     short	  -- output aggreagtive progress information (one-line progress bar)
#     detail	-- output transfer of each file
export rsync_progress_mode=\"short\"

# Auto-continue in case of symlink detecting on top-levels of sync directory:
#     false   -- you'll have to do confirmation for every detection of symlink
#     true    -- you'll get warning message only. Without asking for manual confirmation
export symlinks_auto_continue=\"false\"

export exHard_path=$exHard_path
export snaifServer_addr=$snaifServer_addr
export snaifServer_port=$snaifServer_port
export snaifServer_path=$snaifServer_path
export items4sync=\"$items4sync\"
" | sudo tee $file_conf > /dev/null

echo -e "\n${b}Configurations are saved into \"${file_conf}\"${n}. To check them enter the command: ${b}syncfrom_config${n}\n"
}

# auth. for sudo
sudo echo

printf "${b}Installing syncfrom* scripts on the system... ${n}" && \
sudo cp -f $dir_script/syncfrom* $dir_bin/ && sudo chmod +x $dir_bin/syncfrom* && \
sudo cp -f $dir_script/.syncfrom* $dir_bin/ && sudo chmod +x $dir_bin/.syncfrom* && \
echo "done"

get_exHard_disk_name
get_exHard_path
get_items4sync

echo -e "\n${b}snaifServer:${n}"
printf "\t Input ssh-address (default: $snaifServer_addr): " && read new_snaifServer_addr
if [ "$new_snaifServer_addr" != "" ]; then snaifServer_addr=$new_snaifServer_addr; fi
printf "\t Input ssh-port (default: $snaifServer_port): " && read new_snaifServer_port
if [ "$new_snaifServer_port" != "" ]; then snaifServer_port=$new_snaifServer_port; fi
printf "\t Input path to sync-directory (default: $snaifServer_path): " && read new_snaifServer_path
if [ "$new_snaifServer_path" != "" ]; then snaifServer_path=$new_snaifServer_path; fi

save_conf

