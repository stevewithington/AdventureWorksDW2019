#!/bin/bash

HR="===================================================================================================="

echo "$HR
Running setup.sh ...
$HR"

# run the demo script to create the DB and the schema in the DB
# do this in a loop because the timing for when the SQL instance is ready is indeterminate
for i in {1..60};
do
    /opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P $SA_PASSWORD -d master -i restore.sql
    if [ $? -eq 0 ]
    then
        echo "restore.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done

echo "$HR
setup.sh finished running
$HR"