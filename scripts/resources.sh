#!/bin/bash

get_idle_cpu() {
    local output=$(iostat -c)
    local line=$(echo "$output" | sed -n 4p | sed 's/  */ /g')

    local system=$(echo "$line" | cut -d " " -f 7)
    echo "$system"
}

get_free_mem() {
    local output=$(free | sed -n 2p | sed 's/  */ /g')
    local freemem=$(echo "$output" | cut -d " " -f 4)
    echo "$freemem"
}

mem=$(get_free_mem)
cpu=$(get_idle_cpu)
echo "CPU $cpu"
echo "MEM $mem"
