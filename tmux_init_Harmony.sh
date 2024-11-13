#!/bin/bash
source /etc/profile
source ~/.bashrc

# Start a new tmux session named 'Harmony_services' and create a window named 'services'
tmux new-session -d -s Harmony_services -n services

# Run `ls` in the first pane
tmux send-keys -t Harmony_services:services 'watch kubectl -n atayalan get pods' C-m


# Split the window vertically for the second pane and run `date`
tmux split-window -v -t Harmony_services:services

# Split the first pane vertically for the third pane and run `whoami`
tmux split-window -v -t Harmony_services:services.1

# Set the height of the second pane (pane 1)
tmux send-keys -t Harmony_services:services.2 'watch kubectl -n kube-system get po' C-m

# Move focus to the last created pane
tmux last-pane

# Set the height of the first pane (pane 0) #not working as expected
#tmux resize-pane -t Harmony_services:services.1 -y 5  # Adjust to desired height
#sleep 2

# Attach to the tmux session
tmux attach -t Harmony_services

