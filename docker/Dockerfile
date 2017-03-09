FROM golang:1.6
MAINTAINER ethan@tendermint.com

RUN curl https://glide.sh/get | sh
RUN mkdir -p $GOPATH/github.com/tendermint/ethermint
WORKDIR $GOPATH/src/github.com/tendermint/ethermint
RUN git clone https://github.com/CBAInnovationLab/ethermint.git .
RUN go install ./cmd/ethermint

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
