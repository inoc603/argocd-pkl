FROM busybox as bin

ARG PKL_VERSION=0.25.2
ARG TARGETOS 
ARG TARGETARCH

RUN mkdir -p /usr/local/bin

RUN wget https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-$TARGETOS-$TARGETARCH -O /usr/local/bin/jq
RUN chmod +x /usr/local/bin/jq

RUN wget "https://github.com/apple/pkl/releases/download/$PKL_VERSION/pkl-$TARGETOS-`uname -m`" -O /usr/local/bin/pkl
RUN chmod +x /usr/local/bin/pkl

###############################################################################

FROM debian:stable-slim

COPY --from=bin /usr/local/bin/jq /usr/local/bin/pkl /usr/local/bin/

WORKDIR /home/argocd/cmp-server/config
ADD ./generate.sh .
ADD ./plugin.yaml .
