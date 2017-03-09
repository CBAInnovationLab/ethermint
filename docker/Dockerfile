FROM cbainnovationlab/golang:xenial
MAINTAINER dan.turner@cba.com.au

RUN curl https://glide.sh/get | sh
RUN mkdir -p $GOPATH/github.com/tendermint/ethermint
WORKDIR $GOPATH/src/github.com/tendermint/ethermint
RUN git clone https://github.com/CBAInnovationLab/ethermint.git .
RUN go install ./cmd/ethermint

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y solc

RUN mkdir /ethermint && chmod 777 /ethermint
RUN useradd -ms /bin/bash ethermint
RUN chown ethermint /var/run
USER ethermint 

RUN mkdir -p /ethermint/setup
COPY genesis.json /ethermint/setup/
RUN ethermint -datadir /ethermint/data init /ethermint/setup/genesis.json
COPY keystore /ethermint/data/keystore
EXPOSE 8545

CMD ["ethermint", "-datadir", "/ethermint/data"]
