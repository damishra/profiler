#! /usr/bin/bash

process_array=("bandwidth_hog_burst" "bandwidth_hog" "cpu_hog" "disk_hog" "memory_hog" "memory_hog_leak")

kill_all_processes() {
    for process in "${process_array[@]}"; do
        kill $(pidof "$process")
    done
    exit 0
}

trap kill_all_processes SIGINT SIGTERM

for process in "${process_array[@]}"; do
    ./../resources/bin/$process 100.65.64.174 &
    echo "seconds,%cpu,%mem" >"$process".csv
done

counter=0
while true; do
    sleep 5
    ((counter = counter + 5))
    for process in "${process_array[@]}"; do
        output=$(ps -p $(pidof "$process") -o %cpu,%mem | tail -n +2)
        echo "$counter $output" | sed "s/\s\+/,/g" 1>>"$process".csv
    done
done
