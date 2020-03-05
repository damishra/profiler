#! /usr/bin/bash

process_array=("bandwidth_hog_burst" "bandwidth_hog" "cpu_hog" "disk_hog" "memory_hog" "memory_hog_leak")

# trap process to kill all running processes started by the script.
kill_all_processes() {
    for process in "${process_array[@]}"; do
        kill $(pidof "$process")
    done
    exit 0
}

trap kill_all_processes SIGINT SIGTERM

get_process_metrics() {
    for process in "${process_array[@]}"; do
        output=$(ps -p $(pidof "$process") -o %cpu,%mem | tail -n +2)
        echo "$counter $output" | sed "s/\s\+/,/g" 1>>"$process"_metrics.csv
    done
}

# loop to start all processes required for monitoring.
for process in "${process_array[@]}"; do
    ./../resources/bin/$process 100.65.64.174 &
    echo "seconds,%cpu,%mem" >"$process"_metrics.csv
done

counter=0
while true; do
    sleep 5
    ((counter = counter + 5))
    get_process_metrics
done
