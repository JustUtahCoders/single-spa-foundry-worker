#!/bin/sh

if [ $# -eq 0 ]
then
  echo "Please pass in org name"
  exit 1
fi

sync_env () {
  echo "Syncing ${@:2}"
  pnpm exec wrangler kv:key put org-settings-$1 '{"orgExists": true}' --binding MAIN_KV ${@:2}
  pnpm exec wrangler kv:key put import-map-$1-__main__-systemjs '{"imports": {"react": "https://cdn.single-spa-foundry.com/react.js"}, "scopes": {}}' --binding MAIN_KV ${@:2}
}

echo "Syncing org $1"
sync_env $1 --env dev --preview
sync_env $1 --env dev
sync_env $1 --env test --preview
sync_env $1 --env test
sync_env $1 --preview
