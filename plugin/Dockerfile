FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b as bin

ARG PKL_VERSION=0.25.2
ARG TARGETOS 
ARG TARGETARCH 

ADD ./dep.sh .

RUN chmod +x ./dep.sh
RUN sh -c "TARGETOS=$TARGETOS TARGETARCH=$TARGETARCH ./dep.sh"

###############################################################################

FROM debian:stable-slim@sha256:d10f0545d14bad5f4d230301f7e4fd904384f2dd16fda16d708f936c2fa1db3e

COPY --from=bin /usr/local/bin/jq /usr/local/bin/pkl /usr/local/bin/

WORKDIR /home/argocd/cmp-server/config
ADD ./generate.sh .
ADD ./plugin.yaml .
