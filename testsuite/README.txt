
----
-- Manual testsuit
----

cd ./syncfrom/testsuit

----
-- Like syncfrom_pc_remotePC

export syncFrom_host=localhost
export syncFrom_port=22
export syncFrom_path=/home/adanilov/temp/1/orig
export syncTo_host=localhost
export syncTo_port=22
export syncTo_path=/home/adanilov/temp/1/new
../.syncfrom_general

----
-- Like syncfrom_remotePC_pc

export syncFrom_host=localhost
export syncFrom_port=22
export syncFrom_path=/home/adanilov/temp/1/new
export syncTo_host=localhost
export syncTo_port=22
export syncTo_path=/home/adanilov/temp/1/orig
../.syncfrom_general

----
-- Like syncfrom_pc_exhard

export syncFrom_host=""
export syncFrom_port=""
export syncFrom_path=/home/adanilov/temp/1/orig
export syncTo_host=""
export syncTo_port=""
export syncTo_path=/home/adanilov/temp/1/new
../.syncfrom_general

----
-- Like syncfrom_exhard_pc

export syncFrom_host=""
export syncFrom_port=""
export syncFrom_path=/home/adanilov/temp/1/new
export syncTo_host=""
export syncTo_port=""
export syncTo_path=/home/adanilov/temp/1/orig
../.syncfrom_general

