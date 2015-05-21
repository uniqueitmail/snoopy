#!/bin/bash



### Configure shell and bootstrap
#
set -e
set -u
. `dirname $BASH_SOURCE`/_bootstrap.sh



### Get data
#
VAL_SNOOPY=`$SNOOPY_TEST_DATASOURCE domain`

# Getting domain is tricky on some hosts (Travis CI build boxes return empty string)
# Therefore try multiple sources.
VAL_REAL=`hostname -d`
if [ "$VAL_REAL" == "" ]; then
    SNOOPY_HOSTNAME=`hostname`
    VAL_REAL=`cat /etc/hosts | grep -Eo "$SNOOPY_HOSTNAME\.[-_.a-z0-9]+" | sed -e "s/$SNOOPY_HOSTNAME\.//"`
fi



### Evaluate
#
snoopy_test_compareValues "$VAL_SNOOPY" "$VAL_REAL"