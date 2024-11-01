#!/bin/bash

for cpu in /sys/devices/system/cpu/cpu[1-9]*; do
    if [ -e "$cpu/topology/thread_siblings_list" ]; then
        sibling=$(awk -F '[^0-9]' '{ print $2 }' $cpu/topology/thread_siblings_list)
        if [ ! -z $sibling ]; then
            echo 0 > "/sys/devices/system/cpu/cpu$sibling/online"
        fi
    fi
done

rm -rf /var/lib/kubelet/cpu_manager_state

sleep 10

/usr/bin/systemctl restart rke2-server.service
