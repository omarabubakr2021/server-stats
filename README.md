1. Understanding the Requirements**
Before writing any code, we need to **fully understand** what is required.

📌 **The script should do the following:**  
1. **Analyze server performance** and display:  
   - **Total CPU usage**  
   - **Total memory usage (free vs. used, including percentage)**  
   - **Total disk usage (free vs. used, including percentage)**  
   - **Top 5 processes by CPU usage**  
   - **Top 5 processes by memory usage**  
2. **It should run on any Linux server.**  
3. **The output should be easy to read.**  

---

# **📌 2. Thinking About the Solution**
When solving a problem like this, break it into **small independent parts**, each handling one task. This will make the script modular and easy to manage.

## **🔍 Step 1: Find the Right Commands**
We need Linux commands to fetch the required information:

| **Required Information**  | **Command**  |
|----------------|----------------|
| **CPU Usage** | `top -bn1 | grep "Cpu(s)"` |
| **Memory Usage** | `free -m` or `cat /proc/meminfo` |
| **Disk Usage** | `df -h` |
| **Top 5 CPU-consuming processes** | `ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6` |
| **Top 5 Memory-consuming processes** | `ps -eo pid,comm,%mem --sort=-%mem | head -n 6` |

---

# **📌 3. Writing the Basic Script Structure**
## **✍️ First: Define the Script**
Every Bash script should start with a **shebang** (`#!/bin/bash`) to specify which interpreter to use:
```bash
#!/bin/bash
```
This tells Linux: "Use `/bin/bash` to execute this script."

---

## **✍️ Second: Divide the Script into Functions**
Since we have 5 types of information, we'll write **5 functions**, each responsible for retrieving a specific stat.

### **🚀 Step 1: Function to Get CPU Usage**
```bash
get_cpu_usage() {
    echo "🔹 CPU Usage:"
    top -bn1 | grep "Cpu(s)"
    echo "----------------------"
}
```
✅ **Why did I write it this way?**  
- `top -bn1` captures CPU usage in real-time.  
- `grep "Cpu(s)"` extracts only the CPU-related information.  
- `echo "CPU Usage:"` makes the output clear.  

---

### **🚀 Step 2: Function to Get Memory Usage**
```bash
get_memory_usage() {
    echo "🔹 Memory Usage:"
    free -m
    echo "----------------------"
}
```
✅ **Why `free -m`?**  
- `free -m` shows memory usage in MB, making it easy to read.  

---

### **🚀 Step 3: Function to Get Disk Usage**
```bash
get_disk_usage() {
    echo "🔹 Disk Usage:"
    df -h
    echo "----------------------"
}
```
✅ **Why `df -h`?**  
- `df` displays disk space usage.  
- `-h` makes the output human-readable (GB and MB instead of bytes).  

---

### **🚀 Step 4: Function to Get Top 5 CPU-Consuming Processes**
```bash
get_top_cpu_processes() {
    echo "🔹 Top 5 Processes by CPU usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo "----------------------"
}
```
✅ **Why `ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6`?**  
- `ps -eo pid,comm,%cpu` lists all processes with their process ID (PID), name, and CPU usage.  
- `--sort=-%cpu` sorts them in descending order based on CPU usage.  
- `head -n 6` selects the first 6 lines (1 header + 5 process details).  

---

### **🚀 Step 5: Function to Get Top 5 Memory-Consuming Processes**
```bash
get_top_memory_processes() {
    echo "🔹 Top 5 Processes by Memory usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo "----------------------"
}
```
✅ **Why `ps -eo pid,comm,%mem --sort=-%mem | head -n 6`?**  
- The same logic as `get_top_cpu_processes`, but sorting by `%mem` instead of `%cpu`.  

---

## **📌 4. Creating the Main Function**
Each function is useful on its own, but we need a **main function** to execute all of them in a structured way.
```bash
main() {
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_memory_processes
}
```
✅ **Why create a `main()` function?**  
- It organizes the script and ensures everything runs in the right order.  

---

## **📌 5. Running the Main Function**
Finally, at the bottom of the script, we call `main()` to execute all functions:
```bash
# Execute main function
main
```
✅ **Why is this necessary?**  
- If we don’t call `main`, the script will load the functions but never execute them.  

---

# **📌 6. The Final Script**
```bash
#!/bin/bash

get_cpu_usage() {
    echo "🔹 CPU Usage:"
    top -bn1 | grep "Cpu(s)"
    echo "----------------------"
}

get_memory_usage() {
    echo "🔹 Memory Usage:"
    free -m
    echo "----------------------"
}

get_disk_usage() {
    echo "🔹 Disk Usage:"
    df -h
    echo "----------------------"
}

get_top_cpu_processes() {
    echo "🔹 Top 5 Processes by CPU usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo "----------------------"
}

get_top_memory_processes() {
    echo "🔹 Top 5 Processes by Memory usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo "----------------------"
}

main() {
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_memory_processes
}

# Execute main function
main
```
