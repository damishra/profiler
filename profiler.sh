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

# function to retrieve process metrics.
get_process_metrics() {
    for process in "${process_array[@]}"; do
        local output=$(ps -p $(pidof "$process") -o %cpu,%mem | tail -n +2)
        echo "$counter $output" | sed "s/\s\+/,/g" 1>>"$process"_metrics.csv
    done
}

# function to retrieve system metrics.
get_system_metrics() {
    local disk_space=$(df / | tail -n +2 | awk '{$1=$1}$1' | cut -d ' ' -f 4)
    local disk_write=$(iostat sda | tail -n +7 | awk '{$1=$1}$1' | cut -d ' ' -f 6)
    echo "$counter,,,$disk_write,$disk_space" >>system_metrics.csv
}

# loop to start all processes required for monitoring.
for process in "${process_array[@]}"; do
    ./resources/bin/$process 100.65.64.174 &
    echo "Time,CPU Utilization,Memory Utilization" >"$process"_metrics.csv
done

echo "Time,RX Data Rate,TX Data Rate,Disk Writes,Available Disk Capacity" >system_metrics.csv
counter=0
while true; do
    sleep 5
    ((counter = counter + 5))
    get_process_metrics
    get_system_metrics
done
