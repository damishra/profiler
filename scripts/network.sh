#!/bin/bash

output=$( ifstat lo )
linecount=$( echo "$output" | wc -l )
# echo "$output" | sed -n 2p # header
i=4
while [ $i -lt $linecount ]
do
    line=$( echo "$output" | sed 's/  */ /g' | sed -n ${i}p )

    ifname=$( echo "$line" | cut -f 1 -d " " )
    # rxpkt=$( echo "$line" | cut -f 2 -d " " )
    # rxrate=$( echo "$line" | cut -f 3 -d " " )
    # txpkt=$( echo "$line" | cut -f 4 -d " " )
    # txrate=$( echo "$line" | cut -f 5 -d " " )
    rxdata=$( echo "$line" | cut -f 6 -d " " )
    rxdrate=$( echo "$line" | cut -f 7 -d " " )
    txdata=$( echo "$line" | cut -f 8 -d " " )
    txdrate=$( echo "$line" | cut -f 9 -d " " )
    # echo "$line"
    echo "$ifname [RX $rxdata/$rxdrate] [TX $txdata/$txdrate]"
    (( i += 2 ))
done