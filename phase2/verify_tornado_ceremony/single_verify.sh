#!/bin/bash
set -e

URL=${PHASE2_S3_URL:-https://sherpa-ceremony.s3.eu-central-1.amazonaws.com}

read -p "Enter your contribution number: " input
if [[ -n ${input//[0-9]/} ]]; then
    echo "Contribution ID must be numeric"
    exit 1
fi

if [ ! $input -gt 0 ] || [ $input -gt 4029 ] 
then
   echo "Invalid contribution ID"
   exit 1
fi

wget ${URL}/circuit.json
wget ${URL}/phase1radix2m15

if [ $input == 1 ]
then
    wget ${URL}/initial.params
    mv initial.params response_0
else
    wget ${URL}/response_$((input - 1))
fi

wget ${URL}/response_$input

cargo build --release --bin verify_contribution
../target/release/verify_contribution circuit.json response_$((input - 1)) response_$input
