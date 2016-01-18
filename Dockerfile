FROM ubuntu

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm git build-essential wget libtool autogen
RUN wget https://github.com/ckolivas/cgminer/tarball/v2.11.4
RUN mkdir cgminer
RUN tar zxvf v2.11.4 --directory cgminer
RUN cd ./cgminer/ckolivas-cgminer-* \
    && ./autogen.sh --disable-opencl --disable-adl --enable-cpumining \
    && CFLAGS="-O3" ./configure --disable-opencl --disable-adl --enable-cpumining \
    && make
    
WORKDIR ./cgminer/ckolivas-cgminer-96c8ff5

ENV USER user
ENV PASS pass
ENV URL stratum+tcp://stratum.bitcoin.cz:3333
CMD ./cgminer --user=$USER --pass=$PASS --url=$URL
