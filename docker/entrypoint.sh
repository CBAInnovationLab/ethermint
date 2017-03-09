#!/bin/bash

if [ -n "$ETH_GENESIS_CONTENT" ] && [ ! -f ~/ethereum-genesis.json ]; then
    echo "--> Writing Genesis to ~/ethereum-genesis.json"
    echo $ETH_GENESIS_CONTENT > ~/ethereum-genesis.json
fi

if [ ! -d ~/.ethermint ]; then
    echo "--> Initialising Blockchain"
    ethermint init ~/ethereum-genesis.json
fi

ethermint "$@"
