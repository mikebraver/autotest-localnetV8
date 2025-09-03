# Get the current UTC time
current_utc_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

imuad export --home node1/ | jq > export_f1_$current_utc_time.json