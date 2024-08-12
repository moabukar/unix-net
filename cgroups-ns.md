# C groups and namespaces lab

## Usage

```bash
docker build -t cgroups-namespaces-lab .

docker run -it --rm --name lab_container --privileged cgroups-namespaces-lab

# inside container

## Check cgroups:

cat /proc/self/cgroup

# listns
ls -l /proc/$$/ns
```


## Adding new namespace

`unshare --pid --fork --mount-proc bash`

inside namespace, check process tree

`ps aux`


## Create new network namespace

```bash

ip netns add testns
ip netns exec testns bash

## list net interface in net namespace

ip link

```


## Create new mount namespace

`unshare --mount bash`

### Inside the new mount namespace, mount a new tmpfs:

```bash
mount -t tmpfs tmpfs /mnt
df -h /mnt

```


## C groups

### Creating and Managing Cgroups:

Create a new cgroup for limiting CPU usage.

```bash

mkdir /sys/fs/cgroup/cpu/my_cgroup
echo 50000 > /sys/fs/cgroup/cpu/my_cgroup/cpu.cfs_quota_us
echo $$ > /sys/fs/cgroup/cpu/my_cgroup/tasks

## Check CPU usage limits:
cat /sys/fs/cgroup/cpu/my_cgroup/cpu.cfs_quota_us


```

### Limiting Memory Usage:
Create a new cgroup for limiting memory usage.

```bash
mkdir /sys/fs/cgroup/memory/my_cgroup
echo 100M > /sys/fs/cgroup/memory/my_cgroup/memory.limit_in_bytes
echo $$ > /sys/fs/cgroup/memory/my_cgroup/tasks

## check mem usage limits:

cat /sys/fs/cgroup/memory/my_cgroup/memory.limit_in_bytes

```

## Combine namespaces and Cgroups

```bash
unshare --pid --net --mount --uts --ipc bash
mkdir /sys/fs/cgroup/cpu/my_combined_cgroup
echo 50000 > /sys/fs/cgroup/cpu/my_combined_cgroup/cpu.cfs_quota_us
echo $$ > /sys/fs/cgroup/cpu/my_combined_cgroup/tasks

ls -l /proc/$$/ns
```
