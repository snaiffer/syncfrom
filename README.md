The set of the scripts for simplification synchronization **sync** folder between **pc**,  **exhard** (external hard disk), **remotePC** (via SSH).

**rsync** is used for synchronization.

## Scheme of synchronization

### via USB (snaifExHard):

snaifExHard should be **mounted**.
```
snaifYoga ↔ snaifExHard ↔ snaifServer
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
sudo ./install.sh
```

Note: run it again for reconfiguration.

## Prepare snaifExHard
It should have ext4 filesystem for preserving permissions and flags for folders/files.
1. Detect "dev":
```sh
lsblk
```
2. Format flash drive as ext4:
```sh
sudo umount /dev/sdb1 && sleep 1 && sudo mkfs.ext4 -L "snaifExHard" /dev/sdb1
```
3. Add permissions for current user:
```sh
sudo chown $USER:$USER -R /media/adanilov/snaifExHard
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
