FROM ubuntu:bionic as builder

ARG cmake_version=3.14
ARG cmake_build=5

RUN apt-get update
RUN apt-get install -y wget
RUN wget https://cmake.org/files/v$cmake_version/cmake-$cmake_version.$cmake_build-Linux-x86_64.sh 
RUN mkdir /opt/cmake
RUN sh cmake-$cmake_version.$cmake_build-Linux-x86_64.sh --skip-license --prefix=/opt/cmake


FROM meshell/snapcraft:core18

COPY --from=builder /opt/cmake /opt/cmake
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

RUN apt-get update
RUN apt-get install -y clang-7 lld-7 clang-tidy-7 libc++abi-7-dev libc++-7-dev build-essential

ENV CC=/usr/bin/clang-7
ENV CXX=/usr/bin/clang++-7

