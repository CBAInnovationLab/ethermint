FROM golang:1.6
MAINTAINER dan.turner@cba.com.au

RUN curl https://glide.sh/get | sh
RUN go get github.com/tendermint/ethermint/cmd/ethermint
WORKDIR $GOPATH/src/github.com/tendermint/ethermint
RUN git remote add cba https://github.com/CBAInnovationLab/ethermint.git \
    && git fetch --all \
    && git reset --hard cba/master \
    && git branch --set-upstream-to cba/master

RUN ls -al `which ethermint`
#RUN rm -Rf $GOPATH/bin/ethermint && \
RUN    go install ./cmd/ethermint
#    && go install ./cmd/ethermint
RUN ls -al `which ethermint`

RUN mkdir /ethermint && chmod 777 /ethermint
RUN useradd -ms /bin/bash ethermint
RUN chown ethermint /var/run
USER ethermint

RUN mkdir -p /ethermint/setup
COPY genesis.json /ethermint/setup/
RUN ethermint -datadir /ethermint/data init /ethermint/setup/genesis.json
COPY keystore /ethermint/data/keystore
EXPOSE 8545
EXPOSE 46656
VOLUME /ethermint/data

ENTRYPOINT ["ethermint"]
CMD ["-datadir", "/ethermint/data"]
