# /bin/bash
set -exu

yq e ./ergodash/ergodash_keymap.yaml --output-format=json > ./ergodash/ergodash_keymap.json
yq e ./manta60/manta60_keymap.yaml --output-format=json > ./manta60/manta60_keymap.json
