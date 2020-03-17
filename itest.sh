PWD=`pwd`
TSK=`basename $PWD`
BIN=`find . -iname $TSK.i.t.tsk`
echo "Run $BIN"
$BIN --gtest_filter="*$1*"
