FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install wget tree cmake software-properties-common -y
RUN add-apt-repository -y ppa:jonathonf/ffmpeg-3
RUN apt-get update
RUN apt-get install libavcodec-dev libswscale-dev -y
RUN apt-get install build-essential pkg-config libglib2.0-dev libexpat1-dev libjpeg-dev libexif-dev libpng-dev libtiff-dev -y
COPY ./util/ /tmp/
WORKDIR /tmp
RUN tar xzf vips-8.6.1.tar.gz
WORKDIR /tmp/vips-8.6.1
RUN ./configure
RUN make
RUN make install
WORKDIR /tmp/
RUN mkdir tifig/build -p
WORKDIR /tmp/tifig/build
RUN cmake ..
RUN make
RUN ldconfig -v
RUN cp ./tifig /usr/local/bin
