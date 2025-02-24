
----
-- Manual testsuit
----

export PATH_syncfrom="$(pwd)"
cd ${PATH_syncfrom}/testsuite
export symlinks_auto_continue="true"

----
-- Like syncfrom_pc_remotePC

export syncFrom_host=localhost
export syncFrom_port=22
export syncFrom_path=""
export syncTo_host=localhost
export syncTo_port=22
export syncTo_path=${PATH_syncfrom}/testsuite/external
export items4sync=" \
    ${PATH_syncfrom}/testsuite/pc/archive \
    ${PATH_syncfrom}/testsuite/pc/folder \
    ${PATH_syncfrom}/testsuite/pc/test \
"
../.syncfrom_general

----
-- Like syncfrom_remotePC_pc

export syncFrom_host=localhost
export syncFrom_port=22
export syncFrom_path=${PATH_syncfrom}/testsuite/external
export syncTo_host=localhost
export syncTo_port=22
export syncTo_path=""
export items4sync=" \
    ${PATH_syncfrom}/testsuite/pc/archive \
    ${PATH_syncfrom}/testsuite/pc/folder \
    ${PATH_syncfrom}/testsuite/pc/test \
"
../.syncfrom_general

----
-- Like syncfrom_pc_exhard

export syncFrom_host=""
export syncFrom_port=""
export syncFrom_path=""
export syncTo_host=""
export syncTo_port=""
export syncTo_path=${PATH_syncfrom}/testsuite/external
export items4sync=" \
    ${PATH_syncfrom}/testsuite/pc/archive \
    ${PATH_syncfrom}/testsuite/pc/folder \
    ${PATH_syncfrom}/testsuite/pc/test \
"
../.syncfrom_general

----
-- Like syncfrom_exhard_pc

export syncFrom_host=""
export syncFrom_port=""
export syncFrom_path=${PATH_syncfrom}/testsuite/external
export syncTo_host=""
export syncTo_port=""
export syncTo_path=""
export items4sync=" \
    ${PATH_syncfrom}/testsuite/pc/archive \
    ${PATH_syncfrom}/testsuite/pc/folder \
    ${PATH_syncfrom}/testsuite/pc/test \
"
../.syncfrom_general

