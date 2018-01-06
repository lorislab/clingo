FROM centos/devtoolset-6-toolchain-centos7

ENV CLINGO_VER master

USER root

RUN yum -y install epel-release \
    yum -y clean all

RUN yum -y install git cmake3 \
    yum -y clean all

RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

RUN mkdir /opt/clingo
RUN cd /opt/clingo \
    && git init \
    && git remote add origin https://github.com/potassco/clingo.git \
    && git fetch origin ${CLINGO_VER} \
    && git pull origin ${CLINGO_VER} \
    && git submodule update --init --recursive

RUN yum -y install git make \
    yum -y clean all

WORKDIR /opt/clingo
RUN cmake -H/opt/clingo -B/opt/clingo -DCMAKE_BUILD_TYPE=release \
    && cmake --build /opt/clingo

ENV PATH $PATH:/opt/clingo/bin
