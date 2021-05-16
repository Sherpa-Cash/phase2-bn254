#!/bin/bash

wget https://sherpa-cash-ceremony.s3.amazonaws.com/circuit.json
wget https://sherpa-cash-ceremony.s3.amazonaws.com/phase1radix2m15
wget https://sherpa-cash-ceremony.s3.amazonaws.com/initial.params
mv initial.params response_0

for i in $(seq 0 $1); do
    wget https://sherpa-cash-ceremony.s3.amazonaws.com/response_$i >> download.log 2>&1 &
done
