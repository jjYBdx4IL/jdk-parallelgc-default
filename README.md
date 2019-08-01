Version of https://hg.openjdk.java.net/jdk-updates/jdk11u/ with
default GC reverted back to Java 8 default: ParallelGC

*INOFFICIAL PATCH! USE AT YOUR OWN RISK!*

Background
==========

Starting with Java 9, Oracle decided to switch to G1GC as the default
garbage collector. That GC is usually only preferable in large scale
applications - where you can easily switch the GC in startup scripts
anyways. Where you can NOT change it reliably, is in development
situations where it underperforms ParallelGC by 20-30%. Sadly, there
is no configuration file that lets me specify or change the default,
and in development situations JVMs get started all the time all over
the place where you cannot or don't want to change JVM startup params.

So here it is, the default GC reverted back to Java 8 standard.

* [jdk-11.0.4-internal+0_linux-x64_bin.tar.gz](jdk-11.0.4-internal+0_linux-x64_bin.tar.gz?raw=true)
* [jdk-11.0.4-internal+0_linux-x64_doc-api-spec.tar.gz](jdk-11.0.4-internal+0_linux-x64_doc-api-spec.tar.gz?raw=true)

And here are the commands that have been used to build it:

https://github.com/jjYBdx4IL/snippets/blob/master/java/openjdk11/build_jdk11_with_parallelgc_as_default.sh


