FROM ungawatkt/rpi-spark-210

# Add R list
# RUN echo 'deb http://cran.rstudio.com/bin/linux/debian jessie-cran3/' | sudo tee -a /etc/apt/sources.list.d/r.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update && apt-get install -yq --no-install-recommends --force-yes \
    wget \
    git \
    maven \
    libjansi-java \
    libsvn1 \
    libcurl3 \
    libsasl2-modules \
    autoconf \
    libtool \
    build-essential \
    python-dev \
    python-boto \
    libcurl4-nss-dev \
    libsasl2-dev \
    libsasl2-modules \
    libapr1-dev \
    libsvn-dev \
    automake \
    libz-dev && \
    rm -rf /var/lib/apt/lists/*

# Overall ENV vars
ENV MESOS_BUILD_VERSION 0.28.1
ENV LIVY_BUILD_VERSION livy-server-0.3.0-SNAPSHOT

# Set install path for Livy
ENV LIVY_APP_PATH /apps/$LIVY_BUILD_VERSION

# Set build path for Livy
ENV LIVY_BUILD_PATH /apps/build/livy

# Set Spark home directory
ENV SPARK_HOME /opt/spark


# Set Hadoop config directory
ENV HADOOP_CONF_DIR /opt/hadoop/conf

# Set native Mesos library path
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so

RUN git clone https://github.com/apache/mesos.git
WORKDIR mesos
RUN git checkout tags/0.28.1
# RUN git checkout tags/0.24.1
# ADD mesos.patch /mesos.patch
# ADD add-to-patch.zookeeper /add-to-patch.zookeeper
# RUN git apply < /mesos.patch
# RUN cat /add-to-patch.zookeeper >> 3rdparty/zookeeper-3.4.5.patch

RUN ./bootstrap

RUN mkdir build
WORKDIR /mesos/build
RUN ../configure --disable-python --disable-java
RUN make
RUN mkdir install
RUN make DESTDIR=/mesos/build/install install
RUN tar -C install -zcvf mesos-install.tar.gz .

# Mesos install
#RUN wget http://repos.mesosphere.com/ubuntu/pool/main/m/mesos/mesos_$MESOS_BUILD_VERSION.ubuntu1404_amd64.deb && \
#    dpkg -i mesos_$MESOS_BUILD_VERSION.ubuntu1404_amd64.deb && \
#    rm mesos_$MESOS_BUILD_VERSION.ubuntu1404_amd64.deb

# Clone Livy repository
RUN mkdir -p /apps/build && \
    cd /apps/build && \
    git clone https://github.com/cloudera/livy.git && \
    cd $LIVY_BUILD_PATH && \
    mvn -DskipTests -Dspark.version=$spark_ver clean package && \
    unzip $LIVY_BUILD_PATH/assembly/target/$LIVY_BUILD_VERSION.zip -d /apps && \
    rm -rf $LIVY_BUILD_PATH && \
    mkdir -p $LIVY_APP_PATH/upload

# Add custom files, set permissions
ADD entrypoint.sh .
RUN chmod +x entrypoint.sh

# Expose port
EXPOSE 8998

ENTRYPOINT ["/entrypoint.sh"]
