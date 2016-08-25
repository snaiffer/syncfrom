The set of the scripts for simplification synchronization **sync** folder between **pc**,  **exhard** (external hard disk) and **remotePC** (via SSH).

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
sudo ./install
```

Note: run it again for reconfiguration.

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
