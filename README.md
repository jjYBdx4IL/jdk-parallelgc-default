Version of https://hg.openjdk.java.net/jdk-updates/jdk11u/ with
default GC reverted back to Java 8 default: ParallelGC

*INOFFICIAL PATCH! USE AT YOUR OWN RISK!*

Background
==========

Starting with Java 9, Oracle decided to switch to G1GC as the default
garbage collector. That GC is usually only preferable in large scale
applications - where you can easily switch the GC in startup scripts
anyways. Where you can NOT change it reliably, is in development
situations where it underperforms Java 8's ParallelGC by up to 20%. Sadly, there
is no configuration file that lets me specify or change the default,
and in development situations JVMs get started all the time all over
the place where you cannot or don't want to change JVM startup params.

So here it is, the default GC reverted back to Java 8 standard.

* [jdk-11.0.4-feffbffbfdcaaded+0_linux-x64_bin.tar.gz](jdk-11.0.4-feffbffbfdcaaded+0_linux-x64_bin.tar.gz?raw=true)
* [jdk-11.0.4-feffbffbfdcaaded+0_linux-x64_doc-api-spec.tar.gz](jdk-11.0.4-feffbffbfdcaaded+0_linux-x64_doc-api-spec.tar.gz?raw=true)

* [jdk-12.0.2-ddbedcbdfdacefabafac+0_linux-x64_bin.tar.gz](jdk-12.0.2-ddbedcbdfdacefabafac+0_linux-x64_bin.tar.gz?raw=true)
* [jdk-12.0.2-ddbedcbdfdacefabafac+0_linux-x64_doc-api-spec.tar.gz](jdk-12.0.2-ddbedcbdfdacefabafac+0_linux-x64_doc-api-spec.tar.gz?raw=true)

Test results
============

Benchmark tests have been run on Linux64, using Maven 3.6.1 against some
example build projects, with test units, ITs and most plugins disabled.
Statistics has been calculated from 10 runs/samples for each JVM/JDK.
Each JDK was run using its default GC settings.

### 11.0.4-parallelgc

```
real: (37.328 +/- 178)ms 
user: (102.389 +/- 786)ms 
sys: (3.097 +/- 32)ms
```

### 11.0.4-zulu (G1GC)

```
real: (40.464 +/- 114)ms 
user: (113.446 +/- 657)ms 
sys: (3.224 +/- 23)ms
```

### 8.0.222-zulu (ParallelGC)

```
real: (37.957 +/- 158)ms 
user: (95.322 +/- 907)ms 
sys: (2.743 +/- 23)ms
```


