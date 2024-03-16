#!/bin/sh

echo "ARGOCD_APP_PARAMETERS: $ARGOCD_APP_PARAMETERS" >> /tmp/debug.log

MODULES=$(echo "$ARGOCD_APP_PARAMETERS" | jq -r '. // [{name: "pkl_modules"}] | .[] | select(.name == "pkl_modules").array // ["*.pkl"] | .[]')

/usr/local/bin/pkl eval --cache-dir /tmp/pkl-cache $MODULES
