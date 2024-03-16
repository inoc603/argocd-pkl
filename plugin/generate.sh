#!/bin/sh

MODULES=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '.[] | select(.name == "pkl-modules").array | .[]')

/usr/local/bin/pkl eval --cache-dir /tmp/pkl-cache $MODULES
