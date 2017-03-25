FROM ungawatkt/rpi-openjdk

RUN apt-get update && \
    apt-get install -y openssh-server tar

RUN mkdir ~/.ssh && \
    ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa.pub && \
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

ENV hadoop_ver 2.7.1
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz && \
    tar -xzvf hadoop-${hadoop_ver}.tar.gz && \
    mv hadoop-${hadoop_ver} /opt/hadoop && \
    rm hadoop-${hadoop_ver}.tar.gz

# environment vars
ENV HADOOP_HOME=/opt/hadoop/
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
#ENV HADOOP_OPTS=Djava.library.path=$HADOOP_HOME/lib

# config files
ADD hadoop-env.sh $HADOOP_HOME/conf/
ADD core-site.xml $HADOOP_HOME/conf/
ADD hdfs-site.xml $HADOOP_HOME/conf/
ADD mapred-site.xml $HADOOP_HOME/conf/
ADD yarn-site.xml $HADOOP_HOME/conf/
ADD master $HADOOP_HOME/conf/
ADD slaves  $HADOOP_HOME/conf/

RUN mkdir -p /opt/hadoop_tmp/hdfs/namenode && \
    mkdir -p /opt/hadoop_tmp/hdfs/datanode && \
    hdfs namenode -format


EXPOSE 9000 50010 50020 50070 50075 50090
EXPOSE 8030 8031 8032 8033 8040 8042 8088
