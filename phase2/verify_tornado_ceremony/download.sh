#!/bin/bash
set -e

URL=${PHASE2_S3_URL:-https://sherpa-cash-ceremony.s3.amazonaws.com}

wget ${URL}/circuit.json
wget ${URL}/phase1radix2m15
wget ${URL}/initial.params
mv initial.params response_0

for((i=1; ;++i)); do
    (stat response_$i &> /dev/null) || wget ${URL}/response_$i
done

