## Casuse
Error Msg : kubelet failed with kubelet cgroup driver: “cgroupfs” is different from docker cgroup driver: “systemd”

## Solution

On each of your nodes, install the Docker for your Linux distribution as per Install Docker Engine. You can find the latest validated version of Docker in this dependencies file.

Configure the Docker daemon, in particular to use systemd for the management of the container’s cgroups.

```
sudo mkdir /etc/docker
cat &lt&ltEOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
```

>Note: overlay2 is the preferred storage driver for systems running Linux kernel version 4.0 or higher, or RHEL or CentOS using version 3.10.0-514 and above.


Restart Docker and enable on boot:

```
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```

