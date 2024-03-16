#!/bin/sh

mkdir -p /usr/local/bin

JQ_ARCH=$TARGETARCH
PKL_ARCH=$TARGETARCH

case $TARGETARCH in
    arm*)
        JQ_ARCH=arm64
        PKL_ARCH=aarch64
    ;;
esac

wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-$TARGETOS-$JQ_ARCH -O /usr/local/bin/jq
chmod +x /usr/local/bin/jq

wget "https://github.com/apple/pkl/releases/download/$PKL_VERSION/pkl-$TARGETOS-$PKL_ARCH" -O /usr/local/bin/pkl
chmod +x /usr/local/bin/pkl
