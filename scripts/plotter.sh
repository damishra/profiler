#!/bin/bash

process=$1
seconds=$2
cpu=$3
memory=$4
filename="${process}_metrics.csv"
echo "Writing to $filename"

if [ ! -e "$filename" ]; then
    echo "Time, CPU, Memory" > $filename
fi

echo "$seconds, $cpu, $memory" >> $filename 