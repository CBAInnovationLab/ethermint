#! /bin/bash
set -eu

DOCKER_IMAGE=$1
NETWORK_NAME=$2
ID=$3

set +u
SEEDS=$4
set -u
if [[ "$SEEDS" != "" ]]; then
	SEEDS=" --seeds $SEEDS "
fi

echo "starting tendermint peer ID=$ID yo"
# start ethermint container on the network

echo "docker run -d \
    --net=$NETWORK_NAME \
    --ip=$(test/p2p/ip.sh $ID) \
    --name local_testnet_$ID \
    -v /ethermint/data test/p2p/data/mach$ID \
    $DOCKER_IMAGE --datadir /ethermint/data $SEEDS --log_level=notice"

docker run -d \
	--net=$NETWORK_NAME \
	--ip=$(test/p2p/ip.sh $ID) \
	--name local_testnet_$ID \
    -v /ethermint/data test/p2p/data/mach$ID \
	$DOCKER_IMAGE --datadir /ethermint/data $SEEDS --log_level=notice
