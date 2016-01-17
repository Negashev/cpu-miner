FROM ubuntu

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm git 
RUN git clone https://github.com/pooler/cpuminer.git
WORKDIR ./cpuminer
RUN ./autogen.sh
RUN ./configure CFLAGS="-O3"
RUN apt-get install build-essential -y
RUN make

ENV USER user
ENV PASS pass
ENV URL stratum+tcp://stratum.bitcoin.cz:3333

CMD ./minerd --user=$USER --pass=$PASS --url=$URL