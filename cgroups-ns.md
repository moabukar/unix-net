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



