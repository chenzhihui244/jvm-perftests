# openHAB2

## Results

These results have been measured until now.

| Date/User | OS/JavaVM | ops/m | Results |
| --------- | --------- | ----- | ------- |
| 2015-05-17/jochenhiller | mac-javase8-u45-64bit-server | 212.5 ops/m | [./results/mac-javase8-u45-64bit-server](./results/mac-javase8-u45-64bit-server) |
| 2015-05-18/jochenhiller | linux-jdk-8-oracle-arm-vfp-hflt-32bit-client | 6.64 ops/m | [./results/raspi2-linux-jdk-8-oracle-arm-vfp-hflt-32bit-client](./results/raspi2-linux-jdk-8-oracle-arm-vfp-hflt-32bit-client) |

## Run the tests

## Run the tests

Download scripts to install and run the tests on your target platform.

```
curl -s -o install.sh https://raw.githubusercontent.com/JochenHiller/jvm-perftests/master/openHAB2/install.sh
curl -s -o run.sh https://raw.githubusercontent.com/JochenHiller/jvm-perftests/master/openHAB2/run.sh
curl -s -o benchmark.sh https://raw.githubusercontent.com/JochenHiller/jvm-perftests/master/scripts-common/benchmark.sh
chmod u+x *.sh
# adapt benchmark.sh to your environment, then run the benchmarks
# adapt means:
#   set JAVA_HOME
#   adapt memory settings, number of runs
./benchmark.sh
# see results at ./openHAB2-results
```

## Details

This will simply start openHAB2 with some standard add-on bundles. It will until openHAB2 is up and running.
This is not a thorough test but give some good indicators of running openHAB2 on different JavaVMs in embedded environments.

## References

* https://github.com/openhab/openhab2/blob/2.0.0-alpha2/docs/sources/installation/demo.md

## Open Issues

* run tests on MacOSX
* run tests on Rasp Pi B, B+, Rasp Pi 2, with OpenJDK, JavaSE 7/8 Embedded