#!/bin/bash

function usage() {
  echo "Usage: $0 <jar> <hazelcast-config-path>"
}

# Print usage if incorrect number of args
[[ $# -ne 2 ]] && usage

MAIN_JAR=$1
HAZELCAST_CONFIG=$2
SERVER_CLASS_NAME="com.hazelcast.examples.StartServer"
HADOOP_CONF_PATH=/etc/hadoop/conf
HBASE_CONF_PATH=/etc/hbase/conf

CLASSPATH=$MAIN_JAR:$HADOOP_CONF_PATH:$HBASE_CONF_PATH
JAVA_OPTS="-Xmx1000m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC"

for lib in `ls lib/*.jar`;
do
    CLASSPATH=$CLASSPATH:$lib
done

echo $CLASSPATH

java -Dhazelcast.config=$HAZELCAST_CONFIG $JAVA_OPTS -cp $CLASSPATH $SERVER_CLASS_NAME
