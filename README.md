
The set of the scripts for simplification one-direction synchronization folders from "**items4sync**" list between:
    * **pc**
    * **exhard** (external hard disk)
    * **remotePC** (via SSH).

**rsync** is used for synchronization.
You should make changes in one device between time points of synchronization.
Example:
On **pc** #1:
1. Make changes on **pc** #1
2. Run: ./syncfrom_pc_exhard
On **pc** #2:
3. Run: ./syncfrom_exhard_pc
4. Make changes on **pc** #2

You can select several directories for synchronization on localPC. But they will sync with one directory on exHard or Server.
For example:
    items4sync (on localPC):
        /home/adanilov/sync/work
        /home/adanilov/sync/archive
        /Data/payload
    exHard_path:
        /media/adanilov/exHard/sync
    So all dirs from "items4sync" will be sync to "exHard_path" as:
        /media/adanilov/exHard/sync/work
        /media/adanilov/exHard/sync/archive
        /media/adanilov/exHard/sync/payload

## Scheme of synchronization

### via USB (exHard):

exHard should be **mounted**.
```
localPC ↔ exHard ↔ snaifServer
            ↕
          otherPC
```

### via SSH:

```
pc ↔ remotePC
pc ↔ snaifServer
```


## Installation and configuration

```sh
./install.sh  # !!! without sudo
```

Note: run it again for reconfiguration.

## Example of /etc/syncfrom.conf
```sh
export rsync_progress_mode="short"
symlinks_auto_continue="false"

export exHard_path=/media/adanilov/snaifExHard/sync
export snaifServer_addr=user@192.168.10.10
export snaifServer_port=22
export snaifServer_path=/store
export items4sync=" \
	/home/adanilov/cma \
	/home/adanilov/cma_archive \
	/home/adanilov/cma_payload \
	/home/adanilov/Desktop \
	/home/adanilov/Downloads \
	/home/adanilov/documents \
	/home/adanilov/archive \
	/home/adanilov/BasKet"

```

## Prepare exHard
It should have ext4 filesystem for preserving permissions and flags for folders/files.
1. Detect "dev":
```sh
lsblk
```
2. Format flash drive as ext4:
```sh
sudo umount /dev/sdb1 && sleep 1 && sudo mkfs.ext4 -L "exHard" /dev/sdb1
```
3. Add permissions for current user:
```sh
sudo chown $USER:$USER -R /media/adanilov/exHard
```

## Use

### via USB

exhard → pc

```sh
syncfrom_exhard_pc
```

pc → exhard

```sh
syncfrom_pc_exhard
```

### via SSH

remotePC → pc

```sh
syncfrom_remotePC_pc
```

pc → remotePC

```sh
syncfrom_pc_remotePC
```

snaifServer → pc

```sh
syncfrom_snaifServer_pc
```

pc → snaifServer

```sh
syncfrom_pc_snaifServer
```
