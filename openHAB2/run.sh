#!/bin/bash

echo "Running openHAB2 for Java $JAVA_HOME"

TEST_RESULT_DIR=./openHAB2-results/TEST-RESULT-`date "+%Y%m%d-%H%M%S"`
TEST_RESULT_FILE=$TEST_RESULT_DIR/results.log

rm -rf $TEST_RESULT_DIR
if [ ! -d $TEST_RESULT_DIR ] ; then mkdir -p $TEST_RESULT_DIR ; fi

echo "Test running at `date`" >>$TEST_RESULT_FILE
uname -a >>$TEST_RESULT_FILE
if [ `uname` == Linux ] ; then
  cat /proc/cpuinfo >>$TEST_RESULT_FILE
  if [ `hostname -s` == "raspberrypi" ] ; then
    echo "See http://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/ for hardware revision" >>$TEST_RESULT_FILE
  fi
fi
if [ `uname` == Darwin ] ; then
  sysctl -n machdep.cpu.brand_string >>$TEST_RESULT_FILE
fi

# JavaVM version
$JAVA_HOME/bin/java -version 2>>$TEST_RESULT_FILE


# repeat test N times
NO_OF_RUNS=5
RUN=1
echo "Making $NO_OF_RUNS runs" >>$TEST_RESULT_FILE
while [ $RUN -le $NO_OF_RUNS ] ; do

  echo "Run openHAB2 startup: $RUN of $NO_OF_RUNS runs"
  # unpack distribution
  rm -rf openHAB2
  mkdir openHAB2
  pushd openHAB2 >/dev/null
  unzip -q ../openhab-2.0.0.alpha2-demo.zip

  # export JAVA_HOME/bin to PATH
  export PATH=$JAVA_HOME/bin:$PATH
  ./start_debug.sh 2>&1 >openhab-console.log &
  openHAB2_pid=$!

  # wait until openHAB2 has been started
  while [ true ] ; do
    grep "Startup took" openhab-console.log 2>&1 >/dev/null
    found=$?
    if [ $found == 0 ] ; then break; fi
    sleep 5  
  done
  grep "Startup took" openhab-console.log | sed -e 's/^.*Startup took/Startup took/g' >>../$TEST_RESULT_FILE
  grep "Startup took" openhab-console.log | sed -e 's/^.*Startup took/Startup took/g'

  # now finish java
  java_pid=`pgrep -P $openHAB2_pid java`
  echo "Killing running java..."
  kill -9 $java_pid
  # allow java to quit and free files
  sleep 5 
  mv openhab-console.log ../$TEST_RESULT_DIR/openhab-console-$RUN.log

  popd >/dev/null
  rm -rf openHAB2

  # next run
  RUNS=$((RUN++))
done
