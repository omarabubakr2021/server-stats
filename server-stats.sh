#!/bin/bash

get_os_version() {
    echo "🔹 OS Version:"
    OS=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
    echo "$OS"
    echo "----------------------"
}

get_uptime() {
    echo "🔹 System Uptime:"
    uptime -p
    echo "----------------------"
}

get_loggedin_users() {
    echo "🔹 Logged-in Users:"
    USERS=$(who | wc -l)
    echo "Currently Logged-in Users: $USERS"
    echo "----------------------"
}

get_failed_logins() {
    echo "🔹 Failed Login Attempts:"
    FAILS=$(journalctl -xe | grep 'authentication failure' | wc -l)
    echo "Number of Failed Login Attempts: $FAILS"
    echo "----------------------"
}

get_cpu_usage() {
    echo "🔹 CPU Usage:"
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print "User: "$2"% | System: "$4"% | Idle: "$8"%"}')
    echo "$CPU"
    echo "----------------------"
}

get_memory_usage() {
    echo "🔹 Memory Usage:"
    MEM=$(free -m | awk 'NR==2{printf "Total: %sMB | Used: %sMB | Free: %sMB | Usage: %.2f%%\n", $2, $3, $4, $3*100/$2 }')
    echo "$MEM"
    echo "----------------------"
}

get_disk_usage() {
    echo "🔹 Disk Usage:"
    df -h | grep -E '^/dev/'
    echo "----------------------"
}

get_top_cpu_processes() {
    echo "🔹 Top 5 Processes by CPU usage:"
    echo "PID    | COMMAND         | %CPU"
    echo "--------------------------------"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "%-6s | %-15s | %s%%\n", $1, $2, $3}'
    echo "----------------------"
}

get_top_memory_processes() {
    echo "🔹 Top 5 Processes by Memory usage:"
    echo "PID    | COMMAND         | %MEM"
    echo "--------------------------------"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf "%-6s | %-15s | %s%%\n", $1, $2, $3}'
    echo "----------------------"
}

main() {
    get_os_version
    get_uptime
    get_loggedin_users
    get_failed_logins
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_memory_processes
}

# Execute main function
main

