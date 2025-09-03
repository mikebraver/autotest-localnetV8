#!/bin/bash

imuad start --home ./node1 --minimum-gas-prices 0.0001hua --log_format json --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --grpc.enable true --json-rpc.enable true  --feeder_log_path /workspaces/go-2/localnetV8/node1/logs --oracle > "out1.log"  2>&1 &
pid1 = $!

for i in {2..4}; do
    echo "Starting node$i..."
    # Start the second process
    imuad start --home ./node$i --minimum-gas-prices 0.0001hua --grpc.enable true --feeder_log_path /workspaces/go-2/localnetV8/node$i/logs --oracle  > "out$i.log"  2>&1 &
    pid$i=$!
done

imuad start --home ./Operator1 --json-rpc.enable > "operator.log" 2>&1 &

for i in {1..4}; do
    wait $pid$i
done

echo "All processes have completed."

# --feeder_bin /workspaces/go-2/price-feeder/build/price-feeder