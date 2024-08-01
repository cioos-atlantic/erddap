#!/bin/sh

NORMAL="-server -Xms4G -Xmx12G"
HEAP_DUMP="-XX:+HeapDumpOnOutOfMemoryError"
HEADLESS="-Djava.awt.headless=true"
CONTENT_ROOT="-DerddapContentDirectory=$CATALINA_HOME/content/erddap"
JNA_DIR="-Djna.tmpdir=/tmp/"
FASTBOOT="-Djava.security.egd=file:/dev/./urandom"

JAVA_OPTS="$JAVA_OPTS $NORMAL $HEAP_DUMP $HEADLESS $CONTENT_ROOT/ $JNA_DIR $FASTBOOT"
echo "ERDDAP running with: $JAVA_OPTS"
