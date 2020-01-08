PWD=`pwd`
TSK=`basename $PWD`
BIN=`find . -iname $TSK.u.t.tsk`
echo "Run $BIN"
$BIN --gtest_filter="*$1*"
