The set of the scripts for simplification synchronization **sync** folder between **pc** and **exhard** (external hard disk).

**rsync** is used for synchronization.

As sync folder contained big data it makes impossible synchronization via network. So it's through **wired interface** (for ex.: USB).

#### Scheme of synchronization

```
snaifYoga ↔  **snaifExHard** ↔  snaifServer
                 ↕
               otherPC
```

snaifExHard should be **mounted**.

## Installation and configuration

```sh
sudo ./install
```

Note: run it again for reconfiguration.

## Use
exhard →  pc

```sh
syncfrom_exhard_pc
```

pc →  exhard

```sh
syncfrom_pc_exhard
```
