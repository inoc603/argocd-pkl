FROM busybox

WORKDIR /var/run/argocd/pkl-plugin

RUN \
wget "https://github.com/apple/pkl/releases/download/0.25.2/pkl-linux-aarch64" -O pkl && \
chmod +x pkl
