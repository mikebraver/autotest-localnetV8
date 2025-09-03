#!/bin/bash

# please note this script will automatically update the genesis_time in the genesis file
#GENESIS=genesis_v7_delegationfix.json
#GENESIS=testoutput.json
# GENESIS=genesis_exocoreValidators_instant.json
# GENESIS=testoutput_e2e_07_01.json
# GENESIS=genesis_integration_20250703.json
# TMP_GENESIS=$GENESIS.tmp
GENESIS=genesis_bootstrap_20250728.json
TMP_GENESIS=$GENESIS.tmp


# Get the current UTC time
current_utc_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Print the current UTC time
echo "Current UTC time: $current_utc_time"

# Update the genesis_time in the JSON file
jq --arg time "$current_utc_time" '.genesis_time=$time' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"

for i in {1..4}; do
  cp $GENESIS node$i/config/genesis.json
done

cp $GENESIS Operator1/config/genesis.json

