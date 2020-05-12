#!/bin/bash


path=$(pwd)

filesToProcess() {
  local listFile=filelist
  cat $listFile
}

flags="--bdd  --serializeAST \
  -A cfginnonvoidfunction -A doublefree -A xfree -A uninitializedmemory -A casetermination -A danglingswitchcode -A checkstdlibfuncreturn -A deadstore -A interactiondegree \
  -x CONFIG_ \
  --include $path/mheader.h \
	--include $path/header.h \
  -I $path/busybox-1.28.0/include \
  --platfromHeader ../TypeChef-GNUCHeader/platform.h \
  -I ../TypeChef-GNUCHeader/usr_include \
  -I ../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include \
  -I ../TypeChef-GNUCHeader/x86_64-linux-gnu/4.8/include-fixed \
  -I ../TypeChef-GNUCHeader/x86_64-linux-gnu \
  --openFeat ../TypeChef-GNUCHeader/openfeatures.txt \
  --featureModelDimacs $path/featureModel.dimacs  \
  --recordTiming --parserstatistics --lexNoStdout \
	-U HAVE_LIBDMALLOC \
	-DCONFIG_FIND \
	-U CONFIG_FEATURE_WGET_LONG_OPTIONS \
	-U ENABLE_NC_110_COMPAT \
	-U CONFIG_EXTRA_COMPAT \
	-D_GNU_SOURCE"

filesToProcess|while read i; do
         echo "Analysing $path/busybox-1.28.0/$i.c"
         echo "With settings: $flags"
         ../TypeChef-VAA/typechef.sh  $path/busybox-1.28.0/$i.c $flags
done
