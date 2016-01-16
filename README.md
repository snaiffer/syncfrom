The set of the scripts for simplification synchronization **sync** folder between **pc** and **exhard** (external hard disk).
**rsync** is used for synchronization.
As sync folder conteined big data it makes impossible synchronization via network. So it's through wired interface (for ex.: USB).

#### Scheme of synchronization

snaifYoga ↔  **snaifExHard** ↔  snaifServer
                 ↕
               otherPC

**snaifExHard** should be mounted.

## Installation and configuration

```
sudo ./install
```

Note: run it again for reconfiguration.

## Use
exhard →  pc

```
syncfrom_exhard_pc
```

pc →  exhard

```
syncfrom_pc_exhard
```
